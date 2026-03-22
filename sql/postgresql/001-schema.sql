-- ============================================================
-- Messaging Schema for PostgreSQL 16
-- Based on messaging-schema.md
-- ============================================================

BEGIN;

-- ============================================================
-- ENUM Types
-- ============================================================

CREATE TYPE conversation_type AS ENUM ('direct', 'group');
CREATE TYPE participant_type AS ENUM ('company', 'job_seeker');
CREATE TYPE participant_role AS ENUM ('admin', 'member');
CREATE TYPE sender_type AS ENUM ('company', 'job_seeker', 'system');
CREATE TYPE file_type AS ENUM ('image', 'video', 'pdf', 'file');

-- ============================================================
-- Table 1: conversations
-- ============================================================

CREATE TABLE conversations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type conversation_type NOT NULL,
    name VARCHAR(255) NULL,
    created_by_type participant_type NOT NULL,
    created_by_id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    last_message_at TIMESTAMP NULL,

    CONSTRAINT chk_direct_no_name CHECK (
        type != 'direct' OR name IS NULL
    )
);

-- ============================================================
-- Table 2: conversation_participants
-- ============================================================

CREATE TABLE conversation_participants (
    conversation_id UUID NOT NULL REFERENCES conversations(id),
    participant_type participant_type NOT NULL,
    participant_id BIGINT NOT NULL,
    joined_at TIMESTAMP NOT NULL DEFAULT NOW(),
    left_at TIMESTAMP NULL,
    role participant_role NOT NULL DEFAULT 'member',
    last_read_at TIMESTAMP NULL,
    unread_count INT NOT NULL DEFAULT 0,

    PRIMARY KEY (conversation_id, participant_type, participant_id)
);

-- ============================================================
-- Table 3: messages
-- ============================================================

CREATE TABLE messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL REFERENCES conversations(id),
    sender_type sender_type NOT NULL,
    sender_id BIGINT NULL,
    content TEXT NULL,
    reply_to_message_id UUID NULL REFERENCES messages(id),
    sent_at TIMESTAMP NOT NULL DEFAULT NOW(),
    recalled_at TIMESTAMP NULL,

    CONSTRAINT chk_system_no_sender CHECK (
        (sender_type = 'system' AND sender_id IS NULL)
        OR (sender_type != 'system' AND sender_id IS NOT NULL)
    )
);

-- ============================================================
-- Table 4: message_attachments
-- ============================================================

CREATE TABLE message_attachments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    message_id UUID NOT NULL REFERENCES messages(id),
    file_type file_type NOT NULL,
    file_url VARCHAR(1024) NOT NULL,
    file_name VARCHAR(512) NOT NULL,
    file_size BIGINT NOT NULL,
    thumbnail_url VARCHAR(1024) NULL,
    thumbnail_width INT NULL,
    thumbnail_height INT NULL,
    duration_seconds INT NULL,
    uploaded_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- ============================================================
-- Table 5: message_read_receipts
-- ============================================================

CREATE TABLE message_read_receipts (
    message_id UUID NOT NULL REFERENCES messages(id),
    reader_type participant_type NOT NULL,
    reader_id BIGINT NOT NULL,
    read_at TIMESTAMP NOT NULL,

    PRIMARY KEY (message_id, reader_type, reader_id)
);

-- ============================================================
-- Table 6: direct_conversation_index
-- ============================================================

CREATE TABLE direct_conversation_index (
    company_id BIGINT NOT NULL,
    job_seeker_id BIGINT NOT NULL,
    conversation_id UUID NOT NULL REFERENCES conversations(id) UNIQUE,

    PRIMARY KEY (company_id, job_seeker_id)
);

-- ============================================================
-- Table 7: message_deletions
-- ============================================================

CREATE TABLE message_deletions (
    message_id UUID NOT NULL REFERENCES messages(id),
    deleter_type participant_type NOT NULL,
    deleter_id BIGINT NOT NULL,
    deleted_at TIMESTAMP NOT NULL DEFAULT NOW(),

    PRIMARY KEY (message_id, deleter_type, deleter_id)
);

-- ============================================================
-- Indexes
-- ============================================================

-- 訊息列表分頁（Cursor-based Pagination）
CREATE INDEX idx_messages_conversation_sent_id
ON messages (conversation_id, sent_at DESC, id DESC);

-- 對話列表：由使用者反查參與中的對話
CREATE INDEX idx_conversation_participants_lookup
ON conversation_participants (participant_type, participant_id, left_at, conversation_id);

-- 對話內查有效參與者
CREATE INDEX idx_conversation_participants_active
ON conversation_participants (conversation_id, left_at, participant_type, participant_id);

-- 精確已讀名單
CREATE INDEX idx_read_receipts_reader
ON message_read_receipts (reader_type, reader_id, message_id);

COMMIT;
