CREATE TABLE users (
    id              BIGSERIAL PRIMARY KEY,
    email           VARCHAR(255) NOT NULL UNIQUE,
    password_hash   VARCHAR(255) NOT NULL,
    display_name    VARCHAR(100) NOT NULL,
    role            VARCHAR(20)  NOT NULL DEFAULT 'USER',
    target_level    VARCHAR(10),
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT now()
);

CREATE TABLE vocabulary_items (
    id                  BIGSERIAL PRIMARY KEY,
    level               VARCHAR(10)  NOT NULL,
    word                VARCHAR(100) NOT NULL,
    reading             VARCHAR(100) NOT NULL,
    meaning_vi          VARCHAR(255) NOT NULL,
    meaning_en          VARCHAR(255),
    part_of_speech      VARCHAR(50),
    example_sentence    TEXT,
    example_reading     TEXT,
    example_meaning     TEXT
);
CREATE INDEX idx_vocabulary_items_level ON vocabulary_items (level);

CREATE TABLE kanji_items (
    id              BIGSERIAL PRIMARY KEY,
    level           VARCHAR(10) NOT NULL,
    character       VARCHAR(10) NOT NULL,
    onyomi          VARCHAR(100),
    kunyomi         VARCHAR(100),
    meaning_vi      VARCHAR(255) NOT NULL,
    stroke_count    INT,
    example_words   TEXT
);
CREATE INDEX idx_kanji_items_level ON kanji_items (level);

CREATE TABLE grammar_points (
    id                  BIGSERIAL PRIMARY KEY,
    level               VARCHAR(10) NOT NULL,
    pattern             VARCHAR(255) NOT NULL,
    meaning_vi          VARCHAR(255) NOT NULL,
    meaning_en          VARCHAR(255),
    usage_note          TEXT,
    example_sentence    TEXT,
    example_meaning     TEXT
);
CREATE INDEX idx_grammar_points_level ON grammar_points (level);

CREATE TABLE passages (
    id      BIGSERIAL PRIMARY KEY,
    level   VARCHAR(10)  NOT NULL,
    title   VARCHAR(255) NOT NULL,
    content TEXT NOT NULL
);

CREATE TABLE listening_audios (
    id                  BIGSERIAL PRIMARY KEY,
    level               VARCHAR(10)  NOT NULL,
    title               VARCHAR(255) NOT NULL,
    audio_object_key    VARCHAR(500),
    transcript          TEXT,
    duration_seconds    INT
);

CREATE TABLE questions (
    id                  BIGSERIAL PRIMARY KEY,
    level               VARCHAR(10) NOT NULL,
    skill_type          VARCHAR(20) NOT NULL,
    question_text       TEXT NOT NULL,
    passage_id          BIGINT REFERENCES passages (id),
    listening_audio_id  BIGINT REFERENCES listening_audios (id),
    explanation         TEXT
);
CREATE INDEX idx_questions_level_skill ON questions (level, skill_type);

CREATE TABLE choices (
    id              BIGSERIAL PRIMARY KEY,
    question_id     BIGINT NOT NULL REFERENCES questions (id) ON DELETE CASCADE,
    choice_text     VARCHAR(500) NOT NULL,
    is_correct      BOOLEAN NOT NULL DEFAULT false,
    display_order   INT NOT NULL DEFAULT 0
);
CREATE INDEX idx_choices_question_id ON choices (question_id);

CREATE TABLE exams (
    id                  BIGSERIAL PRIMARY KEY,
    level               VARCHAR(10)  NOT NULL,
    title               VARCHAR(255) NOT NULL,
    exam_type           VARCHAR(20)  NOT NULL,
    skill_type          VARCHAR(20),
    time_limit_minutes  INT NOT NULL DEFAULT 30
);
CREATE INDEX idx_exams_level ON exams (level);

CREATE TABLE exam_questions (
    id              BIGSERIAL PRIMARY KEY,
    exam_id         BIGINT NOT NULL REFERENCES exams (id) ON DELETE CASCADE,
    question_id     BIGINT NOT NULL REFERENCES questions (id) ON DELETE CASCADE,
    display_order   INT NOT NULL DEFAULT 0,
    points          INT NOT NULL DEFAULT 1,
    UNIQUE (exam_id, question_id)
);

CREATE TABLE attempts (
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    exam_id         BIGINT NOT NULL REFERENCES exams (id),
    status          VARCHAR(20) NOT NULL DEFAULT 'IN_PROGRESS',
    started_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    submitted_at    TIMESTAMPTZ,
    score           INT,
    max_score       INT
);
CREATE INDEX idx_attempts_user_id ON attempts (user_id);

CREATE TABLE attempt_answers (
    id                  BIGSERIAL PRIMARY KEY,
    attempt_id          BIGINT NOT NULL REFERENCES attempts (id) ON DELETE CASCADE,
    question_id         BIGINT NOT NULL REFERENCES questions (id),
    selected_choice_id  BIGINT REFERENCES choices (id),
    is_correct          BOOLEAN,
    answered_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (attempt_id, question_id)
);

CREATE TABLE study_progress (
    id                  BIGSERIAL PRIMARY KEY,
    user_id             BIGINT NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    item_type           VARCHAR(20) NOT NULL,
    item_id             BIGINT NOT NULL,
    status              VARCHAR(20) NOT NULL DEFAULT 'NEW',
    last_reviewed_at    TIMESTAMPTZ,
    UNIQUE (user_id, item_type, item_id)
);
CREATE INDEX idx_study_progress_user_id ON study_progress (user_id);
