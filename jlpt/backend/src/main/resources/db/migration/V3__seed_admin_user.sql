-- Default admin account for local/dev use. CHANGE THIS PASSWORD before any non-local deployment.
-- Login: admin@jlpt.local / Admin@12345
INSERT INTO users (id, email, password_hash, display_name, role, target_level)
VALUES (1, 'admin@jlpt.local', '$2a$10$81nGslRqwHIESShzEwJhm.5fHtd1uJzOhCIF0UANQFuRFltqDgF22', 'Administrator', 'ADMIN', NULL);

SELECT setval(pg_get_serial_sequence('users', 'id'), (SELECT MAX(id) FROM users));
