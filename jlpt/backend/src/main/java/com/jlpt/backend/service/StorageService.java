package com.jlpt.backend.service;

import com.jlpt.backend.config.MinioProperties;
import io.minio.*;
import io.minio.http.Method;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
public class StorageService {

    private final MinioClient minioClient;
    private final MinioProperties properties;

    @PostConstruct
    void ensureBucketExists() {
        try {
            boolean exists = minioClient.bucketExists(
                    BucketExistsArgs.builder().bucket(properties.bucket()).build());
            if (!exists) {
                minioClient.makeBucket(MakeBucketArgs.builder().bucket(properties.bucket()).build());
            }
        } catch (Exception e) {
            throw new IllegalStateException("Failed to initialize MinIO bucket: " + properties.bucket(), e);
        }
    }

    public String uploadAudio(MultipartFile file) {
        String objectKey = "listening/" + UUID.randomUUID() + "-" + sanitize(file.getOriginalFilename());
        try (var inputStream = file.getInputStream()) {
            minioClient.putObject(PutObjectArgs.builder()
                    .bucket(properties.bucket())
                    .object(objectKey)
                    .stream(inputStream, file.getSize(), -1)
                    .contentType(file.getContentType())
                    .build());
            return objectKey;
        } catch (Exception e) {
            throw new IllegalStateException("Failed to upload audio file to storage", e);
        }
    }

    public String getPresignedUrl(String objectKey) {
        if (objectKey == null || objectKey.isBlank()) {
            return null;
        }
        try {
            return minioClient.getPresignedObjectUrl(GetPresignedObjectUrlArgs.builder()
                    .method(Method.GET)
                    .bucket(properties.bucket())
                    .object(objectKey)
                    .expiry((int) properties.presignedUrlExpiryMinutes(), TimeUnit.MINUTES)
                    .build());
        } catch (Exception e) {
            throw new IllegalStateException("Failed to generate presigned URL for object: " + objectKey, e);
        }
    }

    private String sanitize(String fileName) {
        if (fileName == null) {
            return "audio";
        }
        return fileName.replaceAll("[^a-zA-Z0-9._-]", "_");
    }
}
