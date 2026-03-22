-- ============================================================
-- Seed Data for MSSQL Server 2019 / 2022
-- 100 conversations (70 direct + 30 group)
-- ============================================================

USE echat;
GO

-- ============================================================
-- Conversations: 70 direct + 30 group = 100
-- ============================================================

INSERT INTO conversations (id, [type], [name], created_by_type, created_by_id, created_at, last_message_at) VALUES
('A0000001-0000-0000-0000-000000000001', 'direct', NULL, 'company', 1, '2026-01-01 09:00:00', '2026-03-20 10:00:00'),
('A0000001-0000-0000-0000-000000000002', 'direct', NULL, 'company', 1, '2026-01-01 09:05:00', '2026-03-19 15:30:00'),
('A0000001-0000-0000-0000-000000000003', 'direct', NULL, 'company', 2, '2026-01-02 10:00:00', '2026-03-18 12:00:00'),
('A0000001-0000-0000-0000-000000000004', 'direct', NULL, 'job_seeker', 1, '2026-01-02 11:00:00', '2026-03-17 09:00:00'),
('A0000001-0000-0000-0000-000000000005', 'direct', NULL, 'company', 3, '2026-01-03 08:00:00', '2026-03-16 14:00:00'),
('A0000001-0000-0000-0000-000000000006', 'direct', NULL, 'job_seeker', 2, '2026-01-03 09:00:00', '2026-03-15 11:00:00'),
('A0000001-0000-0000-0000-000000000007', 'direct', NULL, 'company', 4, '2026-01-04 10:00:00', '2026-03-14 16:00:00'),
('A0000001-0000-0000-0000-000000000008', 'direct', NULL, 'company', 5, '2026-01-04 11:00:00', '2026-03-13 10:00:00'),
('A0000001-0000-0000-0000-000000000009', 'direct', NULL, 'job_seeker', 3, '2026-01-05 08:30:00', '2026-03-12 13:00:00'),
('A0000001-0000-0000-0000-000000000010', 'direct', NULL, 'company', 6, '2026-01-05 09:30:00', '2026-03-11 09:00:00');

-- Conversations 11-70 (direct)
DECLARE @n INT = 11;
WHILE @n <= 70
BEGIN
    INSERT INTO conversations (id, [type], [name], created_by_type, created_by_id, created_at, last_message_at)
    VALUES (
        CAST('A0000001-0000-0000-0000-0000000000' + RIGHT('00' + CAST(@n AS VARCHAR), 2) AS UNIQUEIDENTIFIER),
        'direct', NULL,
        CASE WHEN @n % 3 = 0 THEN 'job_seeker' ELSE 'company' END,
        ((@n - 1) % 10) + 1,
        DATEADD(HOUR, (@n - 1) * 12, '2026-01-01'),
        DATEADD(HOUR, @n, '2026-02-01')
    );
    SET @n = @n + 1;
END;

-- Group conversations (71-100)
INSERT INTO conversations (id, [type], [name], created_by_type, created_by_id, created_at, last_message_at) VALUES
('A0000001-0000-0000-0000-000000000071', 'group', N'前端工程師交流群', 'company', 1, '2026-01-01 10:00:00', '2026-03-20 11:00:00'),
('A0000001-0000-0000-0000-000000000072', 'group', N'後端技術討論', 'company', 2, '2026-01-02 10:00:00', '2026-03-19 14:00:00'),
('A0000001-0000-0000-0000-000000000073', 'group', N'DevOps 團隊', 'company', 3, '2026-01-03 10:00:00', '2026-03-18 16:00:00'),
('A0000001-0000-0000-0000-000000000074', 'group', N'產品設計群', 'company', 4, '2026-01-04 10:00:00', '2026-03-17 10:00:00'),
('A0000001-0000-0000-0000-000000000075', 'group', N'QA 測試團隊', 'company', 5, '2026-01-05 10:00:00', '2026-03-16 15:00:00'),
('A0000001-0000-0000-0000-000000000076', 'group', N'資料科學討論', 'company', 6, '2026-01-06 10:00:00', '2026-03-15 12:00:00'),
('A0000001-0000-0000-0000-000000000077', 'group', N'行動開發群', 'company', 7, '2026-01-07 10:00:00', '2026-03-14 09:00:00'),
('A0000001-0000-0000-0000-000000000078', 'group', N'資安團隊', 'company', 8, '2026-01-08 10:00:00', '2026-03-13 14:00:00'),
('A0000001-0000-0000-0000-000000000079', 'group', N'SRE 值班群', 'company', 9, '2026-01-09 10:00:00', '2026-03-12 11:00:00'),
('A0000001-0000-0000-0000-000000000080', 'group', N'技術面試官群', 'company', 10, '2026-01-10 10:00:00', '2026-03-11 16:00:00'),
('A0000001-0000-0000-0000-000000000081', 'group', N'新人培訓', 'company', 1, '2026-01-11 10:00:00', '2026-03-10 10:00:00'),
('A0000001-0000-0000-0000-000000000082', 'group', N'AI/ML 研究組', 'company', 2, '2026-01-12 10:00:00', '2026-03-09 13:00:00'),
('A0000001-0000-0000-0000-000000000083', 'group', N'雲端架構群', 'company', 3, '2026-01-13 10:00:00', '2026-03-08 09:00:00'),
('A0000001-0000-0000-0000-000000000084', 'group', N'面試回饋群', 'company', 4, '2026-01-14 10:00:00', '2026-03-07 15:00:00'),
('A0000001-0000-0000-0000-000000000085', 'group', N'技術讀書會', 'company', 5, '2026-01-15 10:00:00', '2026-03-06 12:00:00'),
('A0000001-0000-0000-0000-000000000086', 'group', N'開源專案討論', 'company', 6, '2026-01-16 10:00:00', '2026-03-05 10:00:00'),
('A0000001-0000-0000-0000-000000000087', 'group', N'微服務架構群', 'company', 7, '2026-01-17 10:00:00', '2026-03-04 14:00:00'),
('A0000001-0000-0000-0000-000000000088', 'group', N'效能調校團隊', 'company', 8, '2026-01-18 10:00:00', '2026-03-03 11:00:00'),
('A0000001-0000-0000-0000-000000000089', 'group', N'API 設計討論', 'company', 9, '2026-01-19 10:00:00', '2026-03-02 09:00:00'),
('A0000001-0000-0000-0000-000000000090', 'group', N'容器化實踐群', 'company', 10, '2026-01-20 10:00:00', '2026-03-01 16:00:00'),
('A0000001-0000-0000-0000-000000000091', 'group', N'求職者互助群', 'job_seeker', 1, '2026-01-21 10:00:00', '2026-02-28 10:00:00'),
('A0000001-0000-0000-0000-000000000092', 'group', N'面試準備群', 'job_seeker', 2, '2026-01-22 10:00:00', '2026-02-27 13:00:00'),
('A0000001-0000-0000-0000-000000000093', 'group', N'薪資談判討論', 'job_seeker', 3, '2026-01-23 10:00:00', '2026-02-26 09:00:00'),
('A0000001-0000-0000-0000-000000000094', 'group', N'遠端工作交流', 'job_seeker', 4, '2026-01-24 10:00:00', '2026-02-25 15:00:00'),
('A0000001-0000-0000-0000-000000000095', 'group', N'履歷健檢群', 'job_seeker', 5, '2026-01-25 10:00:00', '2026-02-24 12:00:00'),
('A0000001-0000-0000-0000-000000000096', 'group', N'轉職經驗分享', 'job_seeker', 6, '2026-01-26 10:00:00', '2026-02-23 10:00:00'),
('A0000001-0000-0000-0000-000000000097', 'group', N'新鮮人求職群', 'job_seeker', 7, '2026-01-27 10:00:00', '2026-02-22 14:00:00'),
('A0000001-0000-0000-0000-000000000098', 'group', N'外商求職交流', 'job_seeker', 8, '2026-01-28 10:00:00', '2026-02-21 11:00:00'),
('A0000001-0000-0000-0000-000000000099', 'group', N'技術社群活動', 'job_seeker', 9, '2026-01-29 10:00:00', '2026-02-20 09:00:00'),
('A0000001-0000-0000-0000-000000000100', 'group', N'職涯規劃討論', 'job_seeker', 10, '2026-01-30 10:00:00', '2026-02-19 16:00:00');

-- ============================================================
-- Conversation Participants
-- ============================================================

-- Direct conversations 1-10 (explicit)
INSERT INTO conversation_participants (conversation_id, participant_type, participant_id, joined_at, [role], last_read_at, unread_count) VALUES
('A0000001-0000-0000-0000-000000000001', 'company', 1, '2026-01-01 09:00:00', 'member', '2026-03-20 10:00:00', 0),
('A0000001-0000-0000-0000-000000000001', 'job_seeker', 1, '2026-01-01 09:00:00', 'member', '2026-03-20 09:50:00', 1),
('A0000001-0000-0000-0000-000000000002', 'company', 1, '2026-01-01 09:05:00', 'member', '2026-03-19 15:30:00', 0),
('A0000001-0000-0000-0000-000000000002', 'job_seeker', 2, '2026-01-01 09:05:00', 'member', '2026-03-19 15:00:00', 2),
('A0000001-0000-0000-0000-000000000003', 'company', 2, '2026-01-02 10:00:00', 'member', '2026-03-18 11:00:00', 1),
('A0000001-0000-0000-0000-000000000003', 'job_seeker', 3, '2026-01-02 10:00:00', 'member', '2026-03-18 12:00:00', 0),
('A0000001-0000-0000-0000-000000000004', 'company', 3, '2026-01-02 11:00:00', 'member', '2026-03-17 09:00:00', 0),
('A0000001-0000-0000-0000-000000000004', 'job_seeker', 1, '2026-01-02 11:00:00', 'member', '2026-03-17 08:00:00', 1),
('A0000001-0000-0000-0000-000000000005', 'company', 3, '2026-01-03 08:00:00', 'member', '2026-03-16 14:00:00', 0),
('A0000001-0000-0000-0000-000000000005', 'job_seeker', 4, '2026-01-03 08:00:00', 'member', '2026-03-16 13:00:00', 1),
('A0000001-0000-0000-0000-000000000006', 'company', 4, '2026-01-03 09:00:00', 'member', '2026-03-15 10:00:00', 1),
('A0000001-0000-0000-0000-000000000006', 'job_seeker', 2, '2026-01-03 09:00:00', 'member', '2026-03-15 11:00:00', 0),
('A0000001-0000-0000-0000-000000000007', 'company', 4, '2026-01-04 10:00:00', 'member', '2026-03-14 16:00:00', 0),
('A0000001-0000-0000-0000-000000000007', 'job_seeker', 5, '2026-01-04 10:00:00', 'member', '2026-03-14 15:00:00', 1),
('A0000001-0000-0000-0000-000000000008', 'company', 5, '2026-01-04 11:00:00', 'member', '2026-03-13 10:00:00', 0),
('A0000001-0000-0000-0000-000000000008', 'job_seeker', 6, '2026-01-04 11:00:00', 'member', '2026-03-13 09:00:00', 1),
('A0000001-0000-0000-0000-000000000009', 'company', 5, '2026-01-05 08:30:00', 'member', '2026-03-12 12:00:00', 1),
('A0000001-0000-0000-0000-000000000009', 'job_seeker', 3, '2026-01-05 08:30:00', 'member', '2026-03-12 13:00:00', 0),
('A0000001-0000-0000-0000-000000000010', 'company', 6, '2026-01-05 09:30:00', 'member', '2026-03-11 09:00:00', 0),
('A0000001-0000-0000-0000-000000000010', 'job_seeker', 7, '2026-01-05 09:30:00', 'member', '2026-03-11 08:00:00', 1);

-- Direct conversations 11-70 (loop)
DECLARE @i INT = 11;
WHILE @i <= 70
BEGIN
    INSERT INTO conversation_participants (conversation_id, participant_type, participant_id, joined_at, [role], last_read_at, unread_count)
    VALUES (
        CAST('A0000001-0000-0000-0000-0000000000' + RIGHT('00' + CAST(@i AS VARCHAR), 2) AS UNIQUEIDENTIFIER),
        'company', ((@i - 1) % 10) + 1,
        DATEADD(HOUR, (@i - 1) * 12, '2026-01-01'),
        'member',
        DATEADD(HOUR, @i, '2026-03-01'),
        CASE WHEN @i % 3 = 0 THEN 0 ELSE @i % 5 END
    );
    INSERT INTO conversation_participants (conversation_id, participant_type, participant_id, joined_at, [role], last_read_at, unread_count)
    VALUES (
        CAST('A0000001-0000-0000-0000-0000000000' + RIGHT('00' + CAST(@i AS VARCHAR), 2) AS UNIQUEIDENTIFIER),
        'job_seeker', ((@i - 1) % 20) + 1,
        DATEADD(HOUR, (@i - 1) * 12, '2026-01-01'),
        'member',
        DATEADD(HOUR, @i - 1, '2026-03-01'),
        CASE WHEN @i % 4 = 0 THEN 0 ELSE @i % 3 END
    );
    SET @i = @i + 1;
END;

-- Group conversation participants (71-100, 3 members each)
DECLARE @g INT = 71;
WHILE @g <= 100
BEGIN
    -- Creator as admin
    INSERT INTO conversation_participants (conversation_id, participant_type, participant_id, joined_at, [role], last_read_at, unread_count)
    VALUES (
        CAST('A0000001-0000-0000-0000-000000000' + RIGHT('000' + CAST(@g AS VARCHAR), 3) AS UNIQUEIDENTIFIER),
        CASE WHEN @g <= 90 THEN 'company' ELSE 'job_seeker' END,
        ((@g - 71) % 10) + 1,
        DATEADD(DAY, @g - 71, '2026-01-01 10:00:00'),
        'admin',
        DATEADD(DAY, @g - 71, '2026-03-01 10:00:00'),
        0
    );
    -- Second member (different type from creator)
    INSERT INTO conversation_participants (conversation_id, participant_type, participant_id, joined_at, [role], last_read_at, unread_count)
    VALUES (
        CAST('A0000001-0000-0000-0000-000000000' + RIGHT('000' + CAST(@g AS VARCHAR), 3) AS UNIQUEIDENTIFIER),
        CASE WHEN @g <= 90 THEN 'job_seeker' ELSE 'company' END,
        ((@g - 71 + 1) % 20) + 1,
        DATEADD(MINUTE, 5, DATEADD(DAY, @g - 71, '2026-01-01 10:00:00')),
        'member',
        DATEADD(HOUR, -1, DATEADD(DAY, @g - 71, '2026-03-01 10:00:00')),
        1
    );
    -- Third member
    INSERT INTO conversation_participants (conversation_id, participant_type, participant_id, joined_at, [role], last_read_at, unread_count)
    VALUES (
        CAST('A0000001-0000-0000-0000-000000000' + RIGHT('000' + CAST(@g AS VARCHAR), 3) AS UNIQUEIDENTIFIER),
        CASE WHEN @g <= 90 THEN 'company' ELSE 'job_seeker' END,
        ((@g - 71 + 2) % 10) + 1,
        DATEADD(MINUTE, 10, DATEADD(DAY, @g - 71, '2026-01-01 10:00:00')),
        'member',
        DATEADD(HOUR, -2, DATEADD(DAY, @g - 71, '2026-03-01 10:00:00')),
        2
    );
    SET @g = @g + 1;
END;

-- Mark one group member as left
UPDATE conversation_participants
SET left_at = '2026-02-15 10:00:00'
WHERE conversation_id = 'A0000001-0000-0000-0000-000000000073'
  AND participant_type = 'job_seeker'
  AND participant_id = ((73 - 71 + 1) % 20) + 1;

-- ============================================================
-- Direct Conversation Index
-- ============================================================

-- Use ROW_NUMBER to keep only the first conversation per (company, job_seeker) pair
INSERT INTO direct_conversation_index (company_id, job_seeker_id, conversation_id)
SELECT company_id, job_seeker_id, conversation_id
FROM (
    SELECT
        cp_c.participant_id AS company_id,
        cp_j.participant_id AS job_seeker_id,
        c.id AS conversation_id,
        ROW_NUMBER() OVER (PARTITION BY cp_c.participant_id, cp_j.participant_id ORDER BY c.created_at) AS rn
    FROM conversations c
    JOIN conversation_participants cp_c
      ON cp_c.conversation_id = c.id AND cp_c.participant_type = 'company'
    JOIN conversation_participants cp_j
      ON cp_j.conversation_id = c.id AND cp_j.participant_type = 'job_seeker'
    WHERE c.[type] = 'direct'
) t
WHERE rn = 1;

-- ============================================================
-- Messages: 5 explicit for conversations 1-5, then loop for rest
-- ============================================================

-- Conversation 1
INSERT INTO messages (id, conversation_id, sender_type, sender_id, content, sent_at) VALUES
('B0000001-0000-0000-0000-000000000001', 'A0000001-0000-0000-0000-000000000001', 'company', 1, N'您好，我們對您的履歷很有興趣，想邀請您來面試。', '2026-03-20 09:00:00'),
('B0000001-0000-0000-0000-000000000002', 'A0000001-0000-0000-0000-000000000001', 'job_seeker', 1, N'謝謝您的邀請！請問面試時間可以安排在下週嗎？', '2026-03-20 09:30:00'),
('B0000001-0000-0000-0000-000000000003', 'A0000001-0000-0000-0000-000000000001', 'company', 1, N'可以的，我們安排在下週三下午兩點，方便嗎？', '2026-03-20 10:00:00');

-- Conversation 2
INSERT INTO messages (id, conversation_id, sender_type, sender_id, content, sent_at) VALUES
('B0000001-0000-0000-0000-000000000004', 'A0000001-0000-0000-0000-000000000002', 'company', 1, N'您好，想確認您對我們的前端工程師職缺是否有興趣？', '2026-03-19 14:00:00'),
('B0000001-0000-0000-0000-000000000005', 'A0000001-0000-0000-0000-000000000002', 'job_seeker', 2, N'有的！我很感興趣，可以了解更多職缺資訊嗎？', '2026-03-19 14:30:00'),
('B0000001-0000-0000-0000-000000000006', 'A0000001-0000-0000-0000-000000000002', 'company', 1, N'當然，我先寄一份 JD 給您參考。', '2026-03-19 15:30:00');

-- Conversation 3
INSERT INTO messages (id, conversation_id, sender_type, sender_id, content, sent_at) VALUES
('B0000001-0000-0000-0000-000000000007', 'A0000001-0000-0000-0000-000000000003', 'company', 2, N'您好，歡迎來到我們的招募平台！', '2026-03-18 10:00:00'),
('B0000001-0000-0000-0000-000000000008', 'A0000001-0000-0000-0000-000000000003', 'job_seeker', 3, N'謝謝！我正在尋找後端開發的機會。', '2026-03-18 11:00:00'),
('B0000001-0000-0000-0000-000000000009', 'A0000001-0000-0000-0000-000000000003', 'company', 2, N'我們正好有開放 Go 語言後端職缺，有興趣嗎？', '2026-03-18 12:00:00');

-- Conversation 4
INSERT INTO messages (id, conversation_id, sender_type, sender_id, content, sent_at) VALUES
('B0000001-0000-0000-0000-000000000010', 'A0000001-0000-0000-0000-000000000004', 'job_seeker', 1, N'您好，我想了解貴公司的 DevOps 職缺。', '2026-03-17 08:00:00'),
('B0000001-0000-0000-0000-000000000011', 'A0000001-0000-0000-0000-000000000004', 'company', 3, N'歡迎詢問！我們目前在找有 K8s 經驗的工程師。', '2026-03-17 08:30:00'),
('B0000001-0000-0000-0000-000000000012', 'A0000001-0000-0000-0000-000000000004', 'job_seeker', 1, N'太好了，我有三年的 Kubernetes 使用經驗。', '2026-03-17 09:00:00');

-- Conversation 5
INSERT INTO messages (id, conversation_id, sender_type, sender_id, content, sent_at) VALUES
('B0000001-0000-0000-0000-000000000013', 'A0000001-0000-0000-0000-000000000005', 'company', 3, N'面試結果已出，恭喜您通過了第一關！', '2026-03-16 13:00:00'),
('B0000001-0000-0000-0000-000000000014', 'A0000001-0000-0000-0000-000000000005', 'job_seeker', 4, N'太棒了！請問第二關面試會考什麼？', '2026-03-16 13:30:00'),
('B0000001-0000-0000-0000-000000000015', 'A0000001-0000-0000-0000-000000000005', 'company', 3, N'第二關是技術面試，會有白板題和系統設計。', '2026-03-16 14:00:00');

-- Messages for conversations 6-70 (3 per conversation, using loop)
DECLARE @m INT = 6;
WHILE @m <= 70
BEGIN
    DECLARE @base_id INT = (@m - 6) * 3 + 16;
    DECLARE @conv_id UNIQUEIDENTIFIER = CAST('A0000001-0000-0000-0000-0000000000' + RIGHT('00' + CAST(@m AS VARCHAR), 2) AS UNIQUEIDENTIFIER);
    DECLARE @company_id BIGINT = ((@m - 1) % 10) + 1;
    DECLARE @js_id BIGINT = ((@m - 1) % 20) + 1;
    DECLARE @base_time DATETIME2 = DATEADD(DAY, @m - 6, '2026-02-01');

    INSERT INTO messages (id, conversation_id, sender_type, sender_id, content, sent_at) VALUES
    (CAST('B0000001-0000-0000-0000-00000000' + RIGHT('0000' + CAST(@base_id AS VARCHAR), 4) AS UNIQUEIDENTIFIER),
     @conv_id, 'company', @company_id, N'您好，感謝您在平台上投遞履歷！', @base_time),
    (CAST('B0000001-0000-0000-0000-00000000' + RIGHT('0000' + CAST(@base_id + 1 AS VARCHAR), 4) AS UNIQUEIDENTIFIER),
     @conv_id, 'job_seeker', @js_id, N'謝謝回覆，期待有進一步交流的機會。', DATEADD(MINUTE, 30, @base_time)),
    (CAST('B0000001-0000-0000-0000-00000000' + RIGHT('0000' + CAST(@base_id + 2 AS VARCHAR), 4) AS UNIQUEIDENTIFIER),
     @conv_id, 'company', @company_id, N'好的，我們會盡快安排後續流程。', DATEADD(HOUR, 1, @base_time));

    SET @m = @m + 1;
END;

-- Messages for group conversations 71-100 (3 per conversation)
DECLARE @gm INT = 71;
WHILE @gm <= 100
BEGIN
    DECLARE @gbase_id INT = 700 + (@gm - 71) * 3;
    DECLARE @gconv_id UNIQUEIDENTIFIER = CAST('A0000001-0000-0000-0000-000000000' + RIGHT('000' + CAST(@gm AS VARCHAR), 3) AS UNIQUEIDENTIFIER);
    DECLARE @gbase_time DATETIME2 = DATEADD(DAY, @gm - 71, '2026-02-15');

    INSERT INTO messages (id, conversation_id, sender_type, sender_id, content, sent_at) VALUES
    (CAST('B0000001-0000-0000-0000-0000000' + RIGHT('00000' + CAST(@gbase_id AS VARCHAR), 5) AS UNIQUEIDENTIFIER),
     @gconv_id, 'company', ((@gm - 71) % 10) + 1, N'大家好，歡迎加入群組！', @gbase_time),
    (CAST('B0000001-0000-0000-0000-0000000' + RIGHT('00000' + CAST(@gbase_id + 1 AS VARCHAR), 5) AS UNIQUEIDENTIFIER),
     @gconv_id, 'job_seeker', ((@gm - 71 + 1) % 20) + 1, N'嗨，很高興認識大家。', DATEADD(HOUR, 1, @gbase_time)),
    (CAST('B0000001-0000-0000-0000-0000000' + RIGHT('00000' + CAST(@gbase_id + 2 AS VARCHAR), 5) AS UNIQUEIDENTIFIER),
     @gconv_id, 'job_seeker', ((@gm - 71 + 2) % 20) + 1, N'請問有推薦的學習資源嗎？', DATEADD(HOUR, 2, @gbase_time));

    SET @gm = @gm + 1;
END;

-- System message
INSERT INTO messages (id, conversation_id, sender_type, sender_id, content, sent_at) VALUES
('B0000001-0000-0000-0000-000000009999', 'A0000001-0000-0000-0000-000000000001', 'system', NULL, N'此對話已建立', '2026-01-01 09:00:00');

-- Reply reference
UPDATE messages
SET reply_to_message_id = 'B0000001-0000-0000-0000-000000000001'
WHERE id = 'B0000001-0000-0000-0000-000000000002';

-- ============================================================
-- Message Attachments
-- ============================================================

INSERT INTO message_attachments (id, message_id, file_type, file_url, file_name, file_size, thumbnail_url, thumbnail_width, thumbnail_height, duration_seconds, uploaded_at) VALUES
('C0000001-0000-0000-0000-000000000001', 'B0000001-0000-0000-0000-000000000006', 'pdf', N'/attachments/2026/03/jd-frontend.pdf', N'前端工程師_JD.pdf', 245760, NULL, NULL, NULL, NULL, '2026-03-19 15:30:00'),
('C0000001-0000-0000-0000-000000000002', 'B0000001-0000-0000-0000-000000000009', 'image', N'/attachments/2026/03/office-photo.jpg', N'辦公室環境.jpg', 1048576, N'/thumbnails/2026/03/office-photo-thumb.jpg', 200, 150, NULL, '2026-03-18 12:00:00'),
('C0000001-0000-0000-0000-000000000003', 'B0000001-0000-0000-0000-000000000012', 'pdf', N'/attachments/2026/03/resume-k8s.pdf', N'K8s經驗履歷.pdf', 512000, NULL, NULL, NULL, NULL, '2026-03-17 09:00:00'),
('C0000001-0000-0000-0000-000000000004', 'B0000001-0000-0000-0000-000000000001', 'image', N'/attachments/2026/03/company-logo.png', N'公司Logo.png', 102400, N'/thumbnails/2026/03/company-logo-thumb.png', 100, 100, NULL, '2026-03-20 09:00:00'),
('C0000001-0000-0000-0000-000000000005', 'B0000001-0000-0000-0000-000000000015', 'video', N'/attachments/2026/03/interview-guide.mp4', N'面試指南.mp4', 52428800, N'/thumbnails/2026/03/interview-guide-thumb.jpg', 320, 240, 180, '2026-03-16 14:00:00');

-- ============================================================
-- Message Read Receipts
-- ============================================================

INSERT INTO message_read_receipts (message_id, reader_type, reader_id, read_at) VALUES
('B0000001-0000-0000-0000-000000000001', 'job_seeker', 1, '2026-03-20 09:15:00'),
('B0000001-0000-0000-0000-000000000002', 'company', 1, '2026-03-20 09:35:00'),
('B0000001-0000-0000-0000-000000000003', 'job_seeker', 1, '2026-03-20 10:05:00'),
('B0000001-0000-0000-0000-000000000004', 'job_seeker', 2, '2026-03-19 14:10:00'),
('B0000001-0000-0000-0000-000000000005', 'company', 1, '2026-03-19 14:35:00'),
('B0000001-0000-0000-0000-000000000007', 'job_seeker', 3, '2026-03-18 10:10:00'),
('B0000001-0000-0000-0000-000000000008', 'company', 2, '2026-03-18 11:10:00'),
('B0000001-0000-0000-0000-000000000010', 'company', 3, '2026-03-17 08:05:00'),
('B0000001-0000-0000-0000-000000000013', 'job_seeker', 4, '2026-03-16 13:05:00'),
('B0000001-0000-0000-0000-000000000014', 'company', 3, '2026-03-16 13:35:00');

-- ============================================================
-- Message Deletions
-- ============================================================

INSERT INTO message_deletions (message_id, deleter_type, deleter_id, deleted_at) VALUES
('B0000001-0000-0000-0000-000000000004', 'job_seeker', 2, '2026-03-19 16:00:00'),
('B0000001-0000-0000-0000-000000000010', 'job_seeker', 1, '2026-03-17 10:00:00');

-- ============================================================
-- Recalled message
-- ============================================================

UPDATE messages
SET content = NULL, recalled_at = '2026-03-19 14:45:00'
WHERE id = 'B0000001-0000-0000-0000-000000000005';
GO
