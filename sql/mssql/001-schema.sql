-- ============================================================
-- Messaging Schema for MSSQL Server 2019 / 2022
-- Based on messaging-schema.md
-- ============================================================

-- Create database if not exists
IF DB_ID('echat') IS NULL
    CREATE DATABASE echat;
GO

USE echat;
GO

-- ============================================================
-- Table 1: conversations
-- ============================================================

CREATE TABLE conversations (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    [type] VARCHAR(10) NOT NULL,
    [name] NVARCHAR(255) NULL,
    created_by_type VARCHAR(20) NOT NULL,
    created_by_id BIGINT NOT NULL,
    created_at DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    last_message_at DATETIME2 NULL,

    CONSTRAINT chk_conversations_type CHECK ([type] IN ('direct', 'group')),
    CONSTRAINT chk_conversations_created_by_type CHECK (created_by_type IN ('company', 'job_seeker')),
    CONSTRAINT chk_direct_no_name CHECK ([type] != 'direct' OR [name] IS NULL)
);
GO

-- ============================================================
-- Table 2: conversation_participants
-- ============================================================

CREATE TABLE conversation_participants (
    conversation_id UNIQUEIDENTIFIER NOT NULL,
    participant_type VARCHAR(20) NOT NULL,
    participant_id BIGINT NOT NULL,
    joined_at DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    left_at DATETIME2 NULL,
    [role] VARCHAR(10) NOT NULL DEFAULT 'member',
    last_read_at DATETIME2 NULL,
    unread_count INT NOT NULL DEFAULT 0,

    CONSTRAINT pk_conversation_participants PRIMARY KEY (conversation_id, participant_type, participant_id),
    CONSTRAINT fk_cp_conversation FOREIGN KEY (conversation_id) REFERENCES conversations(id),
    CONSTRAINT chk_cp_participant_type CHECK (participant_type IN ('company', 'job_seeker')),
    CONSTRAINT chk_cp_role CHECK ([role] IN ('admin', 'member'))
);
GO

-- ============================================================
-- Table 3: messages
-- ============================================================

CREATE TABLE messages (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    conversation_id UNIQUEIDENTIFIER NOT NULL,
    sender_type VARCHAR(20) NOT NULL,
    sender_id BIGINT NULL,
    content NVARCHAR(MAX) NULL,
    reply_to_message_id UNIQUEIDENTIFIER NULL,
    sent_at DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    recalled_at DATETIME2 NULL,

    CONSTRAINT fk_msg_conversation FOREIGN KEY (conversation_id) REFERENCES conversations(id),
    CONSTRAINT fk_msg_reply_to FOREIGN KEY (reply_to_message_id) REFERENCES messages(id),
    CONSTRAINT chk_msg_sender_type CHECK (sender_type IN ('company', 'job_seeker', 'system')),
    CONSTRAINT chk_msg_system_no_sender CHECK (
        (sender_type = 'system' AND sender_id IS NULL)
        OR (sender_type != 'system' AND sender_id IS NOT NULL)
    )
);
GO

-- ============================================================
-- Table 4: message_attachments
-- ============================================================

CREATE TABLE message_attachments (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    message_id UNIQUEIDENTIFIER NOT NULL,
    file_type VARCHAR(10) NOT NULL,
    file_url NVARCHAR(1024) NOT NULL,
    file_name NVARCHAR(512) NOT NULL,
    file_size BIGINT NOT NULL,
    thumbnail_url NVARCHAR(1024) NULL,
    thumbnail_width INT NULL,
    thumbnail_height INT NULL,
    duration_seconds INT NULL,
    uploaded_at DATETIME2 NOT NULL DEFAULT GETUTCDATE(),

    CONSTRAINT fk_attachment_message FOREIGN KEY (message_id) REFERENCES messages(id),
    CONSTRAINT chk_attachment_file_type CHECK (file_type IN ('image', 'video', 'pdf', 'file'))
);
GO

-- ============================================================
-- Table 5: message_read_receipts
-- ============================================================

CREATE TABLE message_read_receipts (
    message_id UNIQUEIDENTIFIER NOT NULL,
    reader_type VARCHAR(20) NOT NULL,
    reader_id BIGINT NOT NULL,
    read_at DATETIME2 NOT NULL,

    CONSTRAINT pk_message_read_receipts PRIMARY KEY (message_id, reader_type, reader_id),
    CONSTRAINT fk_receipt_message FOREIGN KEY (message_id) REFERENCES messages(id),
    CONSTRAINT chk_receipt_reader_type CHECK (reader_type IN ('company', 'job_seeker'))
);
GO

-- ============================================================
-- Table 6: direct_conversation_index
-- ============================================================

CREATE TABLE direct_conversation_index (
    company_id BIGINT NOT NULL,
    job_seeker_id BIGINT NOT NULL,
    conversation_id UNIQUEIDENTIFIER NOT NULL,

    CONSTRAINT pk_direct_conversation_index PRIMARY KEY (company_id, job_seeker_id),
    CONSTRAINT fk_dci_conversation FOREIGN KEY (conversation_id) REFERENCES conversations(id),
    CONSTRAINT uq_dci_conversation UNIQUE (conversation_id)
);
GO

-- ============================================================
-- Table 7: message_deletions
-- ============================================================

CREATE TABLE message_deletions (
    message_id UNIQUEIDENTIFIER NOT NULL,
    deleter_type VARCHAR(20) NOT NULL,
    deleter_id BIGINT NOT NULL,
    deleted_at DATETIME2 NOT NULL DEFAULT GETUTCDATE(),

    CONSTRAINT pk_message_deletions PRIMARY KEY (message_id, deleter_type, deleter_id),
    CONSTRAINT fk_deletion_message FOREIGN KEY (message_id) REFERENCES messages(id),
    CONSTRAINT chk_deletion_deleter_type CHECK (deleter_type IN ('company', 'job_seeker'))
);
GO

-- ============================================================
-- Indexes
-- ============================================================

CREATE INDEX idx_messages_conversation_sent_id
ON messages (conversation_id, sent_at DESC, id DESC);

CREATE INDEX idx_conversation_participants_lookup
ON conversation_participants (participant_type, participant_id, left_at, conversation_id);

CREATE INDEX idx_conversation_participants_active
ON conversation_participants (conversation_id, left_at, participant_type, participant_id);

CREATE INDEX idx_read_receipts_reader
ON message_read_receipts (reader_type, reader_id, message_id);
GO
