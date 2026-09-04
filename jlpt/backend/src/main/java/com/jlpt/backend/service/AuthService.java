package com.jlpt.backend.service;

import com.jlpt.backend.dto.auth.AuthResponse;
import com.jlpt.backend.dto.auth.LoginRequest;
import com.jlpt.backend.dto.auth.RegisterRequest;
import com.jlpt.backend.entity.User;
import com.jlpt.backend.entity.UserRole;
import com.jlpt.backend.exception.BadRequestException;
import com.jlpt.backend.repository.UserRepository;
import com.jlpt.backend.security.AppUserPrincipal;
import com.jlpt.backend.security.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;

    @Transactional
    public AuthResponse register(RegisterRequest request) {
        if (userRepository.existsByEmail(request.email())) {
            throw new BadRequestException("Email is already registered");
        }

        User user = User.builder()
                .email(request.email())
                .passwordHash(passwordEncoder.encode(request.password()))
                .displayName(request.displayName())
                .role(UserRole.USER)
                .targetLevel(request.targetLevel())
                .build();
        userRepository.save(user);

        AppUserPrincipal principal = new AppUserPrincipal(user);
        return buildAuthResponse(principal);
    }

    public AuthResponse login(LoginRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.email(), request.password()));

        User user = userRepository.findByEmail(request.email())
                .orElseThrow(() -> new BadRequestException("Invalid email or password"));

        AppUserPrincipal principal = new AppUserPrincipal(user);
        return buildAuthResponse(principal);
    }

    public AuthResponse refresh(String refreshToken) {
        String email = jwtService.extractUsername(refreshToken);
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new BadRequestException("Invalid refresh token"));

        AppUserPrincipal principal = new AppUserPrincipal(user);
        if (!jwtService.isTokenValid(refreshToken, principal)) {
            throw new BadRequestException("Invalid or expired refresh token");
        }

        return buildAuthResponse(principal);
    }

    private AuthResponse buildAuthResponse(AppUserPrincipal principal) {
        User user = principal.getUser();
        String accessToken = jwtService.generateAccessToken(principal);
        String refreshToken = jwtService.generateRefreshToken(principal);
        return new AuthResponse(accessToken, refreshToken, user.getId(), user.getEmail(),
                user.getDisplayName(), user.getRole().name());
    }
}
