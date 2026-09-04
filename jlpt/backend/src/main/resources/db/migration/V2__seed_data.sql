-- Seed data: original sample content (NOT copied from real JLPT past papers), for demo/testing purposes.

-- =========================================================================
-- VOCABULARY (10 per level)
-- =========================================================================
INSERT INTO vocabulary_items (id, level, word, reading, meaning_vi, meaning_en, part_of_speech, example_sentence, example_reading, example_meaning) VALUES
(1,  'N5', '食べる', 'たべる', 'ăn', 'to eat', 'verb', '朝ごはんを食べます。', 'あさごはんをたべます。', 'Tôi ăn bữa sáng.'),
(2,  'N5', '飲む', 'のむ', 'uống', 'to drink', 'verb', '水を飲みます。', 'みずをのみます。', 'Tôi uống nước.'),
(3,  'N5', '学校', 'がっこう', 'trường học', 'school', 'noun', '学校へ行きます。', 'がっこうへいきます。', 'Tôi đi đến trường.'),
(4,  'N5', '先生', 'せんせい', 'giáo viên', 'teacher', 'noun', '先生はやさしいです。', 'せんせいはやさしいです。', 'Giáo viên rất hiền.'),
(5,  'N5', '大きい', 'おおきい', 'to, lớn', 'big', 'i-adjective', 'この家は大きいです。', 'このいえはおおきいです。', 'Ngôi nhà này to.'),
(6,  'N5', '新しい', 'あたらしい', 'mới', 'new', 'i-adjective', '新しい本を買いました。', 'あたらしいほんをかいました。', 'Tôi đã mua quyển sách mới.'),
(7,  'N5', '友達', 'ともだち', 'bạn bè', 'friend', 'noun', '友達と遊びます。', 'ともだちとあそびます。', 'Tôi chơi với bạn.'),
(8,  'N5', '毎日', 'まいにち', 'hàng ngày', 'every day', 'adverb', '毎日勉強します。', 'まいにちべんきょうします。', 'Tôi học mỗi ngày.'),
(9,  'N5', '電車', 'でんしゃ', 'tàu điện', 'train', 'noun', '電車で会社へ行きます。', 'でんしゃでかいしゃへいきます。', 'Tôi đi làm bằng tàu điện.'),
(10, 'N5', '話す', 'はなす', 'nói chuyện', 'to speak', 'verb', '日本語を話します。', 'にほんごをはなします。', 'Tôi nói tiếng Nhật.'),

(11, 'N4', '準備', 'じゅんび', 'chuẩn bị', 'preparation', 'noun/suru-verb', '旅行の準備をします。', 'りょこうのじゅんびをします。', 'Tôi chuẩn bị cho chuyến du lịch.'),
(12, 'N4', '説明', 'せつめい', 'giải thích', 'explanation', 'noun/suru-verb', '先生が説明します。', 'せんせいがせつめいします。', 'Giáo viên giải thích.'),
(13, 'N4', '経験', 'けいけん', 'kinh nghiệm', 'experience', 'noun/suru-verb', '海外で働いた経験があります。', 'かいがいではたらいたけいけんがあります。', 'Tôi có kinh nghiệm làm việc ở nước ngoài.'),
(14, 'N4', '到着', 'とうちゃく', 'đến nơi', 'arrival', 'noun/suru-verb', '飛行機が到着しました。', 'ひこうきがとうちゃくしました。', 'Máy bay đã đến nơi.'),
(15, 'N4', '予定', 'よてい', 'dự định', 'plan/schedule', 'noun/suru-verb', '明日は出張の予定です。', 'あしたはしゅっちょうのよていです。', 'Ngày mai tôi dự định đi công tác.'),
(16, 'N4', '都合', 'つごう', 'sự tiện lợi, lịch trình', 'convenience', 'noun', '都合がいい時に来てください。', 'つごうがいいときにきてください。', 'Hãy đến khi nào bạn tiện.'),
(17, 'N4', '大切', 'たいせつ', 'quan trọng', 'important', 'na-adjective', '家族はとても大切です。', 'かぞくはとてもたいせつです。', 'Gia đình rất quan trọng.'),
(18, 'N4', '便利', 'べんり', 'tiện lợi', 'convenient', 'na-adjective', 'このアプリはとても便利です。', 'このアプリはとてもべんりです。', 'Ứng dụng này rất tiện lợi.'),
(19, 'N4', '続ける', 'つづける', 'tiếp tục', 'to continue', 'verb', '毎日運動を続けています。', 'まいにちうんどうをつづけています。', 'Tôi tiếp tục tập thể dục mỗi ngày.'),
(20, 'N4', '比べる', 'くらべる', 'so sánh', 'to compare', 'verb', '去年と比べて暑いです。', 'きょねんとくらべてあついです。', 'So với năm ngoái thì nóng hơn.'),

(21, 'N3', '影響', 'えいきょう', 'ảnh hưởng', 'influence', 'noun/suru-verb', '天気が気分に影響します。', 'てんきがきぶんにえいきょうします。', 'Thời tiết ảnh hưởng đến tâm trạng.'),
(22, 'N3', '環境', 'かんきょう', 'môi trường', 'environment', 'noun', '環境を守ることが大切です。', 'かんきょうをまもることがたいせつです。', 'Bảo vệ môi trường là quan trọng.'),
(23, 'N3', '判断', 'はんだん', 'phán đoán', 'judgment', 'noun/suru-verb', '自分で判断してください。', 'じぶんではんだんしてください。', 'Hãy tự mình phán đoán.'),
(24, 'N3', '状況', 'じょうきょう', 'tình huống', 'situation', 'noun', '状況を説明してください。', 'じょうきょうをせつめいしてください。', 'Hãy giải thích tình huống.'),
(25, 'N3', '努力', 'どりょく', 'nỗ lực', 'effort', 'noun/suru-verb', '合格するために努力します。', 'ごうかくするためにどりょくします。', 'Tôi nỗ lực để đỗ.'),
(26, 'N3', '解決', 'かいけつ', 'giải quyết', 'resolution', 'noun/suru-verb', '問題を解決しました。', 'もんだいをかいけつしました。', 'Tôi đã giải quyết vấn đề.'),
(27, 'N3', '単純', 'たんじゅん', 'đơn giản', 'simple', 'na-adjective', 'この仕事は単純です。', 'このしごとはたんじゅんです。', 'Công việc này đơn giản.'),
(28, 'N3', '複雑', 'ふくざつ', 'phức tạp', 'complicated', 'na-adjective', 'この問題は複雑です。', 'このもんだいはふくざつです。', 'Vấn đề này phức tạp.'),
(29, 'N3', '確認', 'かくにん', 'xác nhận', 'confirmation', 'noun/suru-verb', '予約を確認します。', 'よやくをかくにんします。', 'Tôi xác nhận đặt chỗ.'),
(30, 'N3', '増える', 'ふえる', 'tăng lên', 'to increase', 'verb', '人口が増えています。', 'じんこうがふえています。', 'Dân số đang tăng lên.'),

(31, 'N2', '傾向', 'けいこう', 'xu hướng', 'tendency', 'noun', '最近は値段が上がる傾向にある。', 'さいきんはねだんがあがるけいこうにある。', 'Gần đây giá cả có xu hướng tăng.'),
(32, 'N2', '促進', 'そくしん', 'thúc đẩy', 'promotion', 'noun/suru-verb', '経済成長を促進する。', 'けいざいせいちょうをそくしんする。', 'Thúc đẩy tăng trưởng kinh tế.'),
(33, 'N2', '維持', 'いじ', 'duy trì', 'maintenance', 'noun/suru-verb', '健康を維持する。', 'けんこうをいじする。', 'Duy trì sức khỏe.'),
(34, 'N2', '抑制', 'よくせい', 'kiềm chế', 'restraint', 'noun/suru-verb', '感情を抑制する。', 'かんじょうをよくせいする。', 'Kiềm chế cảm xúc.'),
(35, 'N2', '普及', 'ふきゅう', 'phổ biến, lan rộng', 'diffusion/spread', 'noun/suru-verb', 'スマートフォンが普及した。', 'スマートフォンがふきゅうした。', 'Điện thoại thông minh đã trở nên phổ biến.'),
(36, 'N2', '矛盾', 'むじゅん', 'mâu thuẫn', 'contradiction', 'noun/suru-verb', '彼の話には矛盾がある。', 'かれのはなしにはむじゅんがある。', 'Câu chuyện của anh ấy có mâu thuẫn.'),
(37, 'N2', '慎重', 'しんちょう', 'thận trọng', 'cautious', 'na-adjective', '慎重に判断する。', 'しんちょうにはんだんする。', 'Phán đoán một cách thận trọng.'),
(38, 'N2', '曖昧', 'あいまい', 'mơ hồ', 'ambiguous', 'na-adjective', '曖昧な返事をする。', 'あいまいなへんじをする。', 'Trả lời một cách mơ hồ.'),
(39, 'N2', '見なす', 'みなす', 'coi như là', 'to regard as', 'verb', '沈黙は同意と見なされる。', 'ちんもくはどういとみなされる。', 'Im lặng được coi như là đồng ý.'),
(40, 'N2', '携わる', 'たずさわる', 'tham gia vào', 'to be engaged in', 'verb', '教育に携わる仕事をしています。', 'きょういくにたずさわるしごとをしています。', 'Tôi làm công việc liên quan đến giáo dục.'),

(41, 'N1', '顕著', 'けんちょ', 'rõ rệt', 'remarkable', 'na-adjective', '効果が顕著に表れた。', 'こうかがけんちょにあらわれた。', 'Hiệu quả đã thể hiện rõ rệt.'),
(42, 'N1', '是正', 'ぜせい', 'sửa chữa, chỉnh đốn', 'correction', 'noun/suru-verb', '制度の不備を是正する。', 'せいどのふびをぜせいする。', 'Sửa chữa thiếu sót của chế độ.'),
(43, 'N1', '逸脱', 'いつだつ', 'lệch khỏi, đi chệch', 'deviation', 'noun/suru-verb', '規則から逸脱する。', 'きそくからいつだつする。', 'Đi chệch khỏi quy tắc.'),
(44, 'N1', '遂行', 'すいこう', 'thực hiện, hoàn thành', 'execution', 'noun/suru-verb', '任務を遂行する。', 'にんむをすいこうする。', 'Thực hiện nhiệm vụ.'),
(45, 'N1', '排除', 'はいじょ', 'loại trừ', 'exclusion', 'noun/suru-verb', '不正を排除する。', 'ふせいをはいじょする。', 'Loại trừ gian lận.'),
(46, 'N1', '妥協', 'だきょう', 'thỏa hiệp', 'compromise', 'noun/suru-verb', '互いに妥協する。', 'たがいにだきょうする。', 'Thỏa hiệp lẫn nhau.'),
(47, 'N1', '潜在的', 'せんざいてき', 'tiềm ẩn', 'potential', 'na-adjective', '潜在的なリスクがある。', 'せんざいてきなリスクがある。', 'Có rủi ro tiềm ẩn.'),
(48, 'N1', '一律', 'いちりつ', 'đồng loạt, đồng đều', 'uniformly', 'noun/adverb', '一律に値上げする。', 'いちりつにねあげする。', 'Tăng giá đồng loạt.'),
(49, 'N1', '培う', 'つちかう', 'bồi dưỡng, nuôi dưỡng', 'to cultivate', 'verb', '経験を通じて力を培う。', 'けいけんをつうじてちからをつちかう。', 'Bồi dưỡng năng lực qua kinh nghiệm.'),
(50, 'N1', '携える', 'たずさえる', 'mang theo, cầm theo', 'to carry', 'verb', '書類を携えて出発した。', 'しょるいをたずさえてしゅっぱつした。', 'Mang theo tài liệu rồi xuất phát.');

-- =========================================================================
-- KANJI (8 per level)
-- =========================================================================
INSERT INTO kanji_items (id, level, character, onyomi, kunyomi, meaning_vi, stroke_count, example_words) VALUES
(1,  'N5', '日', 'ニチ・ジツ', 'ひ・か', 'ngày, mặt trời', 4, '日曜日、毎日'),
(2,  'N5', '月', 'ゲツ・ガツ', 'つき', 'tháng, mặt trăng', 4, '一月、月曜日'),
(3,  'N5', '人', 'ジン・ニン', 'ひと', 'người', 2, '日本人、人々'),
(4,  'N5', '水', 'スイ', 'みず', 'nước', 4, '水曜日、水道'),
(5,  'N5', '山', 'サン', 'やま', 'núi', 3, '富士山、山道'),
(6,  'N5', '川', 'セン', 'かわ', 'sông', 3, '川口、小川'),
(7,  'N5', '木', 'モク・ボク', 'き', 'cây', 4, '木曜日、木材'),
(8,  'N5', '火', 'カ', 'ひ', 'lửa', 4, '火曜日、花火'),

(9,  'N4', '週', 'シュウ', '-', 'tuần', 11, '今週、来週'),
(10, 'N4', '曜', 'ヨウ', '-', 'thứ (trong tuần)', 18, '月曜日、何曜日'),
(11, 'N4', '教', 'キョウ', 'おし(える)', 'dạy', 11, '教室、教える'),
(12, 'N4', '室', 'シツ', '-', 'phòng', 9, '教室、地下室'),
(13, 'N4', '病', 'ビョウ', 'やまい', 'bệnh', 10, '病気、病院'),
(14, 'N4', '院', 'イン', '-', 'viện', 10, '病院、大学院'),
(15, 'N4', '駅', 'エキ', '-', 'ga tàu', 14, '駅前、駅員'),
(16, 'N4', '銀', 'ギン', '-', 'bạc', 14, '銀行、銀色'),

(17, 'N3', '経', 'ケイ', 'へ(る)', 'kinh, trải qua', 11, '経験、経済'),
(18, 'N3', '済', 'サイ', 'す(む)', 'xong, kinh tế', 11, '経済、返済'),
(19, 'N3', '験', 'ケン', '-', 'nghiệm', 18, '経験、試験'),
(20, 'N3', '治', 'ジ・チ', 'おさ(める)', 'trị, chữa trị', 8, '政治、治療'),
(21, 'N3', '政', 'セイ', '-', 'chính (trị)', 9, '政治、政府'),
(22, 'N3', '境', 'キョウ', 'さかい', 'biên giới, môi trường', 14, '環境、国境'),
(23, 'N3', '増', 'ゾウ', 'ふ(える)', 'tăng', 14, '増加、増える'),
(24, 'N3', '減', 'ゲン', 'へ(る)', 'giảm', 12, '減少、減る'),

(25, 'N2', '域', 'イキ', '-', 'khu vực', 11, '地域、区域'),
(26, 'N2', '系', 'ケイ', '-', 'hệ, hệ thống', 7, '体系、系統'),
(27, 'N2', '態', 'タイ', '-', 'thái độ, trạng thái', 14, '状態、態度'),
(28, 'N2', '縮', 'シュク', 'ちぢ(む)', 'co lại, rút ngắn', 17, '短縮、縮小'),
(29, 'N2', '拡', 'カク', '-', 'mở rộng', 8, '拡大、拡張'),
(30, 'N2', '抵', 'テイ', '-', 'kháng cự', 8, '抵抗、大抵'),
(31, 'N2', '抗', 'コウ', '-', 'chống lại', 7, '抵抗、対抗'),
(32, 'N2', '憲', 'ケン', '-', 'hiến pháp', 16, '憲法、憲章'),

(33, 'N1', '且', 'カツ', 'か(つ)', 'hơn nữa', 5, '且つ'),
(34, 'N1', '併', 'ヘイ', 'あわ(せる)', 'gộp lại, song song', 8, '併合、併用'),
(35, 'N1', '賂', 'ロ', '-', 'hối lộ', 13, '賄賂'),
(36, 'N1', '賄', 'ワイ', 'まかな(う)', 'hối lộ, chi trả', 13, '賄賂、賄う'),
(37, 'N1', '循', 'ジュン', '-', 'tuần hoàn', 12, '循環'),
(38, 'N1', '環', 'カン', '-', 'vòng, môi trường', 17, '循環、環境'),
(39, 'N1', '卓', 'タク', '-', 'bàn, xuất sắc', 8, '卓越、食卓'),
(40, 'N1', '越', 'エツ', 'こ(える)', 'vượt qua', 12, '卓越、超越');

-- =========================================================================
-- GRAMMAR POINTS (8 per level)
-- =========================================================================
INSERT INTO grammar_points (id, level, pattern, meaning_vi, meaning_en, usage_note, example_sentence, example_meaning) VALUES
(1, 'N5', '〜は〜です', 'A là B', 'A is B', 'Cấu trúc khẳng định cơ bản nhất trong tiếng Nhật.', '私は学生です。', 'Tôi là học sinh.'),
(2, 'N5', '〜を〜ます', 'trợ từ chỉ đối tượng của hành động', 'object particle + verb', 'を đánh dấu tân ngữ trực tiếp của động từ.', 'ご飯を食べます。', 'Tôi ăn cơm.'),
(3, 'N5', '〜に行きます', 'đi đến (địa điểm)', 'to go to', 'に đánh dấu điểm đến khi dùng với 行く/来る/帰る.', '学校に行きます。', 'Tôi đi đến trường.'),
(4, 'N5', '〜たいです', 'muốn làm gì', 'want to do', 'Gắn vào thân masu của động từ để diễn tả mong muốn.', '水が飲みたいです。', 'Tôi muốn uống nước.'),
(5, 'N5', '〜てください', 'làm ơn hãy', 'please do', 'Dùng để yêu cầu, nhờ vả một cách lịch sự.', 'ここに座ってください。', 'Xin hãy ngồi ở đây.'),
(6, 'N5', '〜ませんか', 'bạn có muốn... không?', 'would you like to', 'Dùng để mời ai đó làm gì một cách lịch sự.', '一緒に行きませんか。', 'Bạn có muốn đi cùng không?'),
(7, 'N5', '〜から〜まで', 'từ ... đến ...', 'from ... to ...', 'Diễn tả khoảng thời gian hoặc khoảng cách.', '九時から五時まで働きます。', 'Tôi làm việc từ 9 giờ đến 5 giờ.'),
(8, 'N5', '〜ないでください', 'làm ơn đừng', 'please don''t', 'Yêu cầu ai đó không làm gì.', 'ここでたばこを吸わないでください。', 'Xin đừng hút thuốc ở đây.'),

(9,  'N4', '〜そうです', 'nghe nói rằng / có vẻ như (dựa trên quan sát)', 'it seems / I heard that', 'そうです nối với thể thường để diễn tả suy đoán từ vẻ ngoài hoặc tin nghe được.', '雨が降りそうです。', 'Có vẻ như trời sắp mưa.'),
(10, 'N4', '〜ようです', 'có vẻ như, dường như', 'it appears that', 'Suy đoán dựa trên thông tin hoặc cảm nhận của người nói.', '彼は忙しいようです。', 'Anh ấy có vẻ bận.'),
(11, 'N4', '〜ばいいです', 'chỉ cần làm gì là được', 'it''s enough if you do', 'Diễn tả điều kiện đủ để đạt được kết quả mong muốn.', 'ここに書けばいいです。', 'Chỉ cần viết ở đây là được.'),
(12, 'N4', '〜ことがあります', 'đã từng làm gì', 'have done before', 'Diễn tả kinh nghiệm trong quá khứ.', '日本に行ったことがあります。', 'Tôi đã từng đến Nhật Bản.'),
(13, 'N4', '〜てもいいです', 'làm... cũng được', 'it''s okay to do', 'Cho phép làm một việc gì đó.', 'ここに座ってもいいです。', 'Ngồi ở đây cũng được.'),
(14, 'N4', '〜なければなりません', 'phải làm gì', 'must do', 'Diễn tả nghĩa vụ, sự bắt buộc.', '宿題をしなければなりません。', 'Tôi phải làm bài tập.'),
(15, 'N4', '〜ながら', 'vừa...vừa...', 'while doing', 'Hai hành động diễn ra đồng thời, do cùng một chủ thể thực hiện.', '音楽を聞きながら勉強します。', 'Tôi vừa nghe nhạc vừa học bài.'),
(16, 'N4', '〜と思います', 'tôi nghĩ rằng', 'I think that', 'Diễn tả ý kiến, suy nghĩ của người nói.', '明日は晴れると思います。', 'Tôi nghĩ ngày mai trời sẽ nắng.'),

(17, 'N3', '〜において', 'tại, trong, ở (trang trọng)', 'at / in (formal)', 'Thường dùng trong văn viết hoặc phát biểu trang trọng thay cho で.', 'この会議において重要な決定がされた。', 'Trong cuộc họp này, một quyết định quan trọng đã được đưa ra.'),
(18, 'N3', '〜に対して', 'đối với', 'towards / in response to', 'Chỉ đối tượng của hành động hoặc thái độ.', '質問に対して丁寧に答える。', 'Trả lời một cách lịch sự đối với câu hỏi.'),
(19, 'N3', '〜わけではない', 'không hẳn là', 'it''s not that / doesn''t necessarily mean', 'Phủ định một phần, tránh khẳng định tuyệt đối.', '嫌いなわけではない。', 'Không hẳn là ghét.'),
(20, 'N3', '〜ば〜ほど', 'càng...càng...', 'the more..., the more...', 'Diễn tả mối quan hệ tỉ lệ thuận giữa hai vế.', '練習すればするほど上手になる。', 'Càng luyện tập càng giỏi.'),
(21, 'N3', '〜ざるを得ない', 'không thể không, buộc phải', 'cannot help but', 'Diễn tả việc bắt buộc phải làm dù không muốn.', '状況を考えると行かざるを得ない。', 'Xét tình hình thì không thể không đi.'),
(22, 'N3', '〜おかげで', 'nhờ có', 'thanks to', 'Diễn tả kết quả tốt nhờ một nguyên nhân nào đó.', 'あなたのおかげで成功した。', 'Nhờ có bạn mà tôi đã thành công.'),
(23, 'N3', '〜せいで', 'do lỗi/tại vì (mang sắc thái tiêu cực)', 'because of (negative)', 'Diễn tả kết quả xấu do một nguyên nhân nào đó.', '雨のせいで電車が遅れた。', 'Do trời mưa nên tàu điện bị trễ.'),
(24, 'N3', '〜通りに', 'đúng như', 'as / according to', 'Diễn tả sự làm theo đúng một chuẩn mực, hướng dẫn.', '説明通りにやってください。', 'Hãy làm đúng như hướng dẫn.'),

(25, 'N2', '〜に伴って', 'cùng với, đi kèm với', 'along with', 'Diễn tả một sự việc xảy ra cùng với sự thay đổi của việc khác.', '経済成長に伴って生活が便利になった。', 'Cùng với sự tăng trưởng kinh tế, cuộc sống trở nên tiện lợi hơn.'),
(26, 'N2', '〜にもかかわらず', 'mặc dù, bất chấp', 'despite / in spite of', 'Diễn tả sự tương phản, kết quả trái ngược với dự đoán.', '雨にもかかわらず出かけた。', 'Mặc dù trời mưa vẫn đi ra ngoài.'),
(27, 'N2', '〜を問わず', 'bất kể, không phân biệt', 'regardless of', 'Diễn tả việc không bị giới hạn bởi yếu tố nào đó.', '年齢を問わず参加できます。', 'Bất kể tuổi tác đều có thể tham gia.'),
(28, 'N2', '〜からして', 'xét từ, chỉ riêng... đã', 'judging from', 'Đưa ra một ví dụ điển hình để suy ra điều gì đó.', '態度からして分かる。', 'Chỉ nhìn thái độ là biết được.'),
(29, 'N2', '〜だけあって', 'đúng như, không hổ danh là', 'as expected of', 'Khen ngợi, thể hiện kết quả tương xứng với một đặc điểm nào đó.', '経験があるだけあって仕事が上手だ。', 'Đúng như có kinh nghiệm, làm việc rất giỏi.'),
(30, 'N2', '〜どころか', 'đừng nói là, chưa nói đến', 'far from', 'Phủ định mạnh, nhấn mạnh sự trái ngược với kỳ vọng.', '100点どころか0点だった。', 'Đừng nói 100 điểm, tôi được 0 điểm.'),
(31, 'N2', '〜に反して', 'trái với', 'contrary to', 'Diễn tả kết quả trái ngược với dự đoán, mong đợi.', '予想に反して結果は悪かった。', 'Trái với dự đoán, kết quả không tốt.'),
(32, 'N2', '〜を契機に', 'lấy làm cơ hội, bước ngoặt', 'triggered by / taking the opportunity of', 'Diễn tả một sự kiện làm khởi đầu cho một thay đổi.', 'この事件を契機に規則が変わった。', 'Lấy sự việc này làm bước ngoặt, quy định đã thay đổi.'),

(33, 'N1', '〜べからず', 'cấm, không được (văn phong cổ, trang trọng)', 'must not (formal/classical)', 'Thường thấy trên biển báo, quy định mang tính trang trọng.', '芝生に入るべからず。', 'Cấm vào bãi cỏ.'),
(34, 'N1', '〜ではあるまいし', 'đâu phải là... (mà)', 'it''s not as if...', 'Dùng để phê phán nhẹ, so sánh với một trường hợp không hợp lý.', '子供ではあるまいし、自分で決めなさい。', 'Đâu phải trẻ con, hãy tự quyết định đi.'),
(35, 'N1', '〜を余儀なくされる', 'buộc phải (do hoàn cảnh)', 'to be forced to', 'Diễn tả việc bị hoàn cảnh bắt buộc phải làm điều gì đó.', '台風のためイベントは中止を余儀なくされた。', 'Do bão nên sự kiện buộc phải hủy bỏ.'),
(36, 'N1', '〜ないまでも', 'dù không đến mức', 'even if not to the extent of', 'Đưa ra mức độ thấp hơn nhưng vẫn chấp nhận được.', '毎日でないまでも週に一度は運動したい。', 'Dù không phải mỗi ngày nhưng tôi muốn tập thể dục ít nhất một tuần một lần.'),
(37, 'N1', '〜んがために', 'để nhằm mục đích (văn phong cổ)', 'in order to (classical)', 'Diễn tả mục đích mạnh mẽ, văn phong trang trọng/cổ.', '成功せんがために努力を続けた。', 'Anh ấy tiếp tục nỗ lực để nhằm mục đích thành công.'),
(38, 'N1', '〜極まりない', 'vô cùng, cực kỳ (mang sắc thái tiêu cực)', 'extremely (negative)', 'Nhấn mạnh mức độ cực đoan của một tính chất tiêu cực.', '彼の態度は失礼極まりない。', 'Thái độ của anh ta vô cùng thất lễ.'),
(39, 'N1', '〜きらいがある', 'có khuynh hướng (không tốt)', 'to have a tendency to (negative)', 'Chỉ ra một khuynh hướng không tốt mang tính bản chất.', '彼は遅刻するきらいがある。', 'Anh ấy có khuynh hướng đi trễ.'),
(40, 'N1', '〜に足る', 'đáng để, xứng đáng', 'worthy of', 'Diễn tả mức độ đủ để xứng đáng với điều gì đó.', '信頼するに足る人物だ。', 'Đó là người đáng để tin tưởng.');

-- =========================================================================
-- PASSAGES (Reading, 1 per level)
-- =========================================================================
INSERT INTO passages (id, level, title, content) VALUES
(1, 'N5', 'わたしの一日',
 'わたしは毎朝六時に起きます。それから、顔を洗って、朝ごはんを食べます。七時半に家を出て、電車で会社へ行きます。仕事は九時から五時までです。夜は友達と晩ごはんを食べたり、テレビを見たりします。'),
(2, 'N4', 'スマートフォンの使い方',
 '最近、スマートフォンを使う人がとても多くなりました。若い人だけでなく、お年寄りも便利に使っています。しかし、使いすぎると目が疲れたり、夜眠れなくなったりすることもあります。使う時間を決めて、上手に付き合うことが大切です。'),
(3, 'N3', 'ごみのリサイクル',
 '日本では、ごみを出すときに種類ごとに分けなければならない。燃えるごみ、燃えないごみ、資源ごみなどに分別することで、リサイクルがしやすくなる。最初は面倒に感じる人も多いが、慣れてくると自然に分けられるようになる。環境を守るために、一人一人の協力が欠かせない。'),
(4, 'N2', '働き方の変化',
 '近年、日本企業の働き方は大きく変化しつつある。従来の終身雇用や年功序列といった制度は見直され、成果に応じて評価される仕組みを導入する企業が増えている。また、在宅勤務やフレックスタイム制度を取り入れることで、社員が仕事と生活のバランスを取りやすくなった。こうした変化は、企業の競争力を高める一方で、社員一人一人の自己管理能力がより求められるようになっている。'),
(5, 'N1', '情報化社会と個人の在り方',
 '情報技術の発展により、私たちは膨大な量の情報に瞬時にアクセスできるようになった。その利便性は計り知れないが、同時に、情報の真偽を見極める力がこれまで以上に求められている。安易に情報を鵜呑みにすることは、誤った判断を招きかねない。情報化社会を生き抜くためには、批判的に物事を捉え、多角的な視点から検証する姿勢が不可欠である。');

-- =========================================================================
-- LISTENING AUDIOS (1 per level) - audio_object_key left NULL; upload later via admin API
-- =========================================================================
INSERT INTO listening_audios (id, level, title, audio_object_key, transcript, duration_seconds) VALUES
(1, 'N5', '駅までの道', NULL,
 'すみません、駅までどうやって行きますか。この道をまっすぐ行って、二つ目の信号を右に曲がってください。駅は左側にあります。', 25),
(2, 'N4', 'レストランの予約', NULL,
 'もしもし、今晩七時に二人で予約したいのですが。すみません、七時はいっぱいです。八時なら空いています。では、八時でお願いします。', 30),
(3, 'N3', '会議の連絡', NULL,
 '明日の会議ですが、場所が変更になりました。三階の会議室ではなく、五階の第二会議室で行いますので、お間違えのないようにお願いします。時間は変わらず午前十時からです。', 35),
(4, 'N2', '新製品発表会', NULL,
 '本日はお忙しい中お集まりいただきありがとうございます。弊社の新製品は、従来品に比べて消費電力を三十パーセント削減しながら、処理速度は二倍に向上しております。発売は来月十五日を予定しております。', 40),
(5, 'N1', '経済講演の一部', NULL,
 '少子高齢化が進む中で、労働力人口の減少は避けられない課題となっている。この状況に対応するためには、外国人労働者の受け入れ拡大だけでなく、生産性の向上や、女性・高齢者の労働参加を促す制度改革が不可欠である。', 45);

-- =========================================================================
-- QUESTIONS
-- =========================================================================

-- Reading questions (ids 1-10), 2 per level, linked to passages
INSERT INTO questions (id, level, skill_type, question_text, passage_id, listening_audio_id, explanation) VALUES
(1, 'N5', 'READING', 'わたしは何時に起きますか。', 1, NULL, '本文に「わたしは毎朝六時に起きます」とあります。'),
(2, 'N5', 'READING', 'わたしは仕事の後、何をしますか。', 1, NULL, '本文に「夜は友達と晩ごはんを食べたり」とあります。'),
(3, 'N4', 'READING', '誰がスマートフォンを使っていますか。', 2, NULL, '本文に「若い人だけでなく、お年寄りも便利に使っています」とあります。'),
(4, 'N4', 'READING', 'スマートフォンを使いすぎるとどうなりますか。', 2, NULL, '本文に「使いすぎると目が疲れたり」とあります。'),
(5, 'N3', 'READING', '日本でごみを出すときに何をしなければなりませんか。', 3, NULL, '本文に「ごみを出すときに種類ごとに分けなければならない」とあります。'),
(6, 'N3', 'READING', '筆者は何が大切だと言っていますか。', 3, NULL, '本文に「一人一人の協力が欠かせない」とあります。'),
(7, 'N2', 'READING', '従来の日本企業の制度としてあげられているものは何か。', 4, NULL, '本文に「従来の終身雇用や年功序列といった制度」とあります。'),
(8, 'N2', 'READING', 'この変化によって社員に求められるようになったことは何か。', 4, NULL, '本文に「社員一人一人の自己管理能力がより求められる」とあります。'),
(9, 'N1', 'READING', '情報化社会で求められている力は何か。', 5, NULL, '本文に「情報の真偽を見極める力がこれまで以上に求められている」とあります。'),
(10, 'N1', 'READING', '筆者が不可欠だと述べている姿勢は何か。', 5, NULL, '本文に「多角的な視点から検証する姿勢が不可欠である」とあります。');

-- Listening questions (ids 11-20), 2 per level, linked to listening_audios
INSERT INTO questions (id, level, skill_type, question_text, passage_id, listening_audio_id, explanation) VALUES
(11, 'N5', 'LISTENING', '駅はどこにありますか。', NULL, 1, '「二つ目の信号を右に曲がってください。駅は左側にあります」と説明しています。'),
(12, 'N5', 'LISTENING', '何を右に曲がりますか。', NULL, 1, '「二つ目の信号を右に曲がってください」とあります。'),
(13, 'N4', 'LISTENING', '何時に予約しましたか。', NULL, 2, '七時はいっぱいで、八時に予約しています。'),
(14, 'N4', 'LISTENING', '何人で予約しましたか。', NULL, 2, '「今晩七時に二人で予約したい」とあります。'),
(15, 'N3', 'LISTENING', '会議はどこで行われますか。', NULL, 3, '「五階の第二会議室で行います」とあります。'),
(16, 'N3', 'LISTENING', '会議は何時からですか。', NULL, 3, '「時間は変わらず午前十時からです」とあります。'),
(17, 'N2', 'LISTENING', '新製品の特徴として正しいものはどれか。', NULL, 4, '「処理速度は二倍に向上しております」とあります。'),
(18, 'N2', 'LISTENING', '発売はいつの予定か。', NULL, 4, '「発売は来月十五日を予定しております」とあります。'),
(19, 'N1', 'LISTENING', '労働力人口減少への対応策として挙げられていないものはどれか。', NULL, 5, '出生率を強制的に引き上げるとは述べられていません。'),
(20, 'N1', 'LISTENING', 'この講演のテーマは何か。', NULL, 5, '少子高齢化と労働力問題について述べています。');

-- Vocabulary practice questions (ids 21-35), 3 per level
INSERT INTO questions (id, level, skill_type, question_text, passage_id, listening_audio_id, explanation) VALUES
(21, 'N5', 'VOCABULARY', '「先生」の読み方はどれですか。', NULL, NULL, '「先生」は「せんせい」と読みます。'),
(22, 'N5', 'VOCABULARY', '「＿＿＿を飲みます。」に入る言葉はどれですか。', NULL, NULL, '「水を飲みます」が自然です。'),
(23, 'N5', 'VOCABULARY', '「あたらしい　ほん」の「あたらしい」を漢字で書くとどれですか。', NULL, NULL, '「あたらしい」は「新しい」と書きます。'),
(24, 'N4', 'VOCABULARY', '「じゅんび」を漢字で書くとどれですか。', NULL, NULL, '「じゅんび」は「準備」と書きます。'),
(25, 'N4', 'VOCABULARY', '「この道具はとても＿＿＿です。」に入る言葉はどれですか。', NULL, NULL, '「便利」が最も自然です。'),
(26, 'N4', 'VOCABULARY', '「けいけん」の意味に最も近いのはどれですか。', NULL, NULL, '「けいけん（経験）」は「体験」に近い意味です。'),
(27, 'N3', 'VOCABULARY', '「この問題は＿＿＿です。簡単に答えが出ません。」に入る言葉はどれですか。', NULL, NULL, '「複雑」が文脈に合います。'),
(28, 'N3', 'VOCABULARY', '「かんきょう」を漢字で書くとどれですか。', NULL, NULL, '「かんきょう」は「環境」と書きます。'),
(29, 'N3', 'VOCABULARY', '「増える」の対義語はどれですか。', NULL, NULL, '「増える」の反対の意味は「減る」です。'),
(30, 'N2', 'VOCABULARY', '「彼の話には＿＿＿がある。」に入る言葉はどれですか。', NULL, NULL, '「矛盾」が文脈に合います。'),
(31, 'N2', 'VOCABULARY', '「あいまい」を漢字で書くとどれですか。', NULL, NULL, '「あいまい」は「曖昧」と書きます。'),
(32, 'N2', 'VOCABULARY', '「慎重」の意味に最も近いのはどれですか。', NULL, NULL, '「慎重」は「注意深い」に近い意味です。'),
(33, 'N1', 'VOCABULARY', '「規則から＿＿＿する。」に入る言葉はどれですか。', NULL, NULL, '「逸脱」が文脈に合います。'),
(34, 'N1', 'VOCABULARY', '「けんちょ」を漢字で書くとどれですか。', NULL, NULL, '「けんちょ」は「顕著」と書きます。'),
(35, 'N1', 'VOCABULARY', '「妥協」の意味に最も近いのはどれですか。', NULL, NULL, '「妥協」は「譲り合って合意すること」という意味です。');

-- Grammar practice questions (ids 36-50), 3 per level
INSERT INTO questions (id, level, skill_type, question_text, passage_id, listening_audio_id, explanation) VALUES
(36, 'N5', 'GRAMMAR', '「水が＿＿＿。」に入る言葉はどれですか。', NULL, NULL, '「〜たいです」は「〜したい」という希望を表します。'),
(37, 'N5', 'GRAMMAR', '「ここに座って＿＿＿。」に入る言葉はどれですか。', NULL, NULL, '「〜てください」は丁寧な依頼を表します。'),
(38, 'N5', 'GRAMMAR', '「九時＿＿＿五時まで働きます。」に入る言葉はどれですか。', NULL, NULL, '「から〜まで」は期間の始まりと終わりを表します。'),
(39, 'N4', 'GRAMMAR', '「日本に行った＿＿＿あります。」に入る言葉はどれですか。', NULL, NULL, '「〜ことがあります」は過去の経験を表します。'),
(40, 'N4', 'GRAMMAR', '「宿題をし＿＿＿なりません。」に入る言葉はどれですか。', NULL, NULL, '「〜なければなりません」は義務を表します。'),
(41, 'N4', 'GRAMMAR', '「音楽を聞き＿＿＿勉強します。」に入る言葉はどれですか。', NULL, NULL, '「〜ながら」は同時に行う動作を表します。'),
(42, 'N3', 'GRAMMAR', '「練習すれば＿＿＿上手になる。」に入る言葉はどれですか。', NULL, NULL, '「〜ば〜ほど」は比例関係を表します。'),
(43, 'N3', 'GRAMMAR', '「雨の＿＿＿電車が遅れた。」に入る言葉はどれですか。', NULL, NULL, '「〜せいで」は悪い結果の原因を表します。'),
(44, 'N3', 'GRAMMAR', '「嫌いな＿＿＿ない。」に入る言葉はどれですか。', NULL, NULL, '「〜わけではない」は部分否定を表します。'),
(45, 'N2', 'GRAMMAR', '「雨＿＿＿出かけた。」に入る言葉はどれですか。', NULL, NULL, '「〜にもかかわらず」は逆接を表します。'),
(46, 'N2', 'GRAMMAR', '「経済成長＿＿＿、生活が便利になった。」に入る言葉はどれですか。', NULL, NULL, '「〜に伴って」は付随して起こる変化を表します。'),
(47, 'N2', 'GRAMMAR', '「年齢＿＿＿参加できます。」に入る言葉はどれですか。', NULL, NULL, '「〜を問わず」は「関係なく」という意味です。'),
(48, 'N1', 'GRAMMAR', '「台風のため、イベントは中止を＿＿＿。」に入る言葉はどれですか。', NULL, NULL, '「〜を余儀なくされる」は「やむを得ずそうする」という意味です。'),
(49, 'N1', 'GRAMMAR', '「彼の態度は失礼＿＿＿。」に入る言葉はどれですか。', NULL, NULL, '「〜極まりない」は程度が甚だしいことを表します。'),
(50, 'N1', 'GRAMMAR', '「彼は遅刻する＿＿＿がある。」に入る言葉はどれですか。', NULL, NULL, '「〜きらいがある」は好ましくない傾向を表します。');

-- =========================================================================
-- CHOICES (4 per question, in question id order)
-- =========================================================================
INSERT INTO choices (id, question_id, choice_text, is_correct, display_order) VALUES
-- Q1 (reading N5)
(1, 1, '六時', true, 1), (2, 1, '七時半', false, 2), (3, 1, '九時', false, 3), (4, 1, '五時', false, 4),
-- Q2
(5, 2, '電車に乗る', false, 1), (6, 2, '朝ごはんを食べる', false, 2), (7, 2, '友達と晩ごはんを食べる', true, 3), (8, 2, '顔を洗う', false, 4),
-- Q3
(9, 3, '若い人だけ', false, 1), (10, 3, 'お年寄りだけ', false, 2), (11, 3, '若い人もお年寄りも', true, 3), (12, 3, '子供だけ', false, 4),
-- Q4
(13, 4, '頭がよくなる', false, 1), (14, 4, '目が疲れる', true, 2), (15, 4, 'お金がもうかる', false, 3), (16, 4, '友達が増える', false, 4),
-- Q5
(17, 5, 'ごみを燃やす', false, 1), (18, 5, 'ごみを種類ごとに分ける', true, 2), (19, 5, 'ごみを外国に送る', false, 3), (20, 5, 'ごみを毎日出す', false, 4),
-- Q6
(21, 6, 'ごみを増やすこと', false, 1), (22, 6, '一人一人が協力すること', true, 2), (23, 6, 'ごみを捨てないこと', false, 3), (24, 6, 'ごみを輸出すること', false, 4),
-- Q7
(25, 7, '成果主義', false, 1), (26, 7, '終身雇用', true, 2), (27, 7, '在宅勤務', false, 3), (28, 7, 'フレックスタイム', false, 4),
-- Q8
(29, 8, 'より長く働くこと', false, 1), (30, 8, '自己管理能力', true, 2), (31, 8, '転職すること', false, 3), (32, 8, '給料を減らすこと', false, 4),
-- Q9
(33, 9, '情報を早く集める力', false, 1), (34, 9, '情報の真偽を見極める力', true, 2), (35, 9, '情報を暗記する力', false, 3), (36, 9, '情報を発信する力', false, 4),
-- Q10
(37, 10, '情報を鵜呑みにする姿勢', false, 1), (38, 10, '多角的な視点から検証する姿勢', true, 2), (39, 10, '情報を無視する姿勢', false, 3), (40, 10, '一つの情報源に頼る姿勢', false, 4),
-- Q11 (listening N5)
(41, 11, 'まっすぐ行った所', false, 1), (42, 11, '右に曲がってすぐ', false, 2), (43, 11, '信号を右に曲がって左側', true, 3), (44, 11, '信号の前', false, 4),
-- Q12
(45, 12, '一つ目の角', false, 1), (46, 12, '二つ目の信号', true, 2), (47, 12, '駅の前', false, 3), (48, 12, '橋', false, 4),
-- Q13
(49, 13, '七時', false, 1), (50, 13, '七時半', false, 2), (51, 13, '八時', true, 3), (52, 13, '八時半', false, 4),
-- Q14
(53, 14, '一人', false, 1), (54, 14, '二人', true, 2), (55, 14, '三人', false, 3), (56, 14, '四人', false, 4),
-- Q15
(57, 15, '三階の会議室', false, 1), (58, 15, '五階の第二会議室', true, 2), (59, 15, '一階のロビー', false, 3), (60, 15, '本社ビル', false, 4),
-- Q16
(61, 16, '午前九時', false, 1), (62, 16, '午前十時', true, 2), (63, 16, '午後一時', false, 3), (64, 16, '午後三時', false, 4),
-- Q17
(65, 17, '消費電力が増えた', false, 1), (66, 17, '処理速度が二倍になった', true, 2), (67, 17, '価格が下がった', false, 3), (68, 17, 'デザインが変わった', false, 4),
-- Q18
(69, 18, '今月十五日', false, 1), (70, 18, '来月十五日', true, 2), (71, 18, '来月三十日', false, 3), (72, 18, '再来月', false, 4),
-- Q19
(73, 19, '外国人労働者の受け入れ拡大', false, 1), (74, 19, '生産性の向上', false, 2), (75, 19, '女性の労働参加促進', false, 3), (76, 19, '出生率の強制的な引き上げ', true, 4),
-- Q20
(77, 20, '少子高齢化と労働力問題', true, 1), (78, 20, '外国人観光客の増加', false, 2), (79, 20, '教育制度改革', false, 3), (80, 20, '年金制度の詳細', false, 4),
-- Q21 (vocab N5)
(81, 21, 'せんせい', true, 1), (82, 21, 'せんせえ', false, 2), (83, 21, 'せいせん', false, 3), (84, 21, 'せんぜい', false, 4),
-- Q22
(85, 22, '水', true, 1), (86, 22, '学校', false, 2), (87, 22, '先生', false, 3), (88, 22, '友達', false, 4),
-- Q23
(89, 23, '新しい', true, 1), (90, 23, '親しい', false, 2), (91, 23, '新らしい', false, 3), (92, 23, '深しい', false, 4),
-- Q24 (vocab N4)
(93, 24, '準備', true, 1), (94, 24, '準美', false, 2), (95, 24, '準否', false, 3), (96, 24, '準日', false, 4),
-- Q25
(97, 25, '便利', true, 1), (98, 25, '大切', false, 2), (99, 25, '経験', false, 3), (100, 25, '都合', false, 4),
-- Q26
(101, 26, '予定', false, 1), (102, 26, '説明', false, 2), (103, 26, '体験', true, 3), (104, 26, '都合', false, 4),
-- Q27 (vocab N3)
(105, 27, '単純', false, 1), (106, 27, '複雑', true, 2), (107, 27, '確認', false, 3), (108, 27, '努力', false, 4),
-- Q28
(109, 28, '環境', true, 1), (110, 28, '監境', false, 2), (111, 28, '環鏡', false, 3), (112, 28, '還境', false, 4),
-- Q29
(113, 29, '減る', true, 1), (114, 29, '増す', false, 2), (115, 29, '伸びる', false, 3), (116, 29, '広がる', false, 4),
-- Q30 (vocab N2)
(117, 30, '矛盾', true, 1), (118, 30, '普及', false, 2), (119, 30, '促進', false, 3), (120, 30, '維持', false, 4),
-- Q31
(121, 31, '曖昧', true, 1), (122, 31, '暖味', false, 2), (123, 31, '愛昧', false, 3), (124, 31, '曖味', false, 4),
-- Q32
(125, 32, '注意深い', true, 1), (126, 32, '簡単な', false, 2), (127, 32, '急いだ', false, 3), (128, 32, '曖昧な', false, 4),
-- Q33 (vocab N1)
(129, 33, '逸脱', true, 1), (130, 33, '是正', false, 2), (131, 33, '遂行', false, 3), (132, 33, '排除', false, 4),
-- Q34
(133, 34, '顕著', true, 1), (134, 34, '顕着', false, 2), (135, 34, '現著', false, 3), (136, 34, '顕暑', false, 4),
-- Q35
(137, 35, '譲り合って合意すること', true, 1), (138, 35, '完全に拒否すること', false, 2), (139, 35, '一方的に決めること', false, 3), (140, 35, '争い続けること', false, 4),
-- Q36 (grammar N5)
(141, 36, '飲みたいです', true, 1), (142, 36, '飲みます', false, 2), (143, 36, '飲んでください', false, 3), (144, 36, '飲みません', false, 4),
-- Q37
(145, 37, 'ください', true, 1), (146, 37, 'たいです', false, 2), (147, 37, 'ませんか', false, 3), (148, 37, 'から', false, 4),
-- Q38
(149, 38, 'から', true, 1), (150, 38, 'を', false, 2), (151, 38, 'に', false, 3), (152, 38, 'で', false, 4),
-- Q39 (grammar N4)
(153, 39, 'ことが', true, 1), (154, 39, 'ようが', false, 2), (155, 39, 'そうが', false, 3), (156, 39, 'ながら', false, 4),
-- Q40
(157, 40, 'なければ', true, 1), (158, 40, 'てもいい', false, 2), (159, 40, 'ながら', false, 3), (160, 40, 'そうに', false, 4),
-- Q41
(161, 41, 'ながら', true, 1), (162, 41, 'そうに', false, 2), (163, 41, 'ように', false, 3), (164, 41, 'ばいいように', false, 4),
-- Q42 (grammar N3)
(165, 42, 'するほど', true, 1), (166, 42, 'したせいで', false, 2), (167, 42, 'したわけで', false, 3), (168, 42, 'したとおりに', false, 4),
-- Q43
(169, 43, 'せいで', true, 1), (170, 43, 'おかげで', false, 2), (171, 43, 'わけで', false, 3), (172, 43, 'ほどで', false, 4),
-- Q44
(173, 44, 'わけでは', true, 1), (174, 44, 'せいでは', false, 2), (175, 44, 'おかげでは', false, 3), (176, 44, 'ほどでは', false, 4),
-- Q45 (grammar N2)
(177, 45, 'にもかかわらず', true, 1), (178, 45, 'に伴って', false, 2), (179, 45, 'を問わず', false, 3), (180, 45, 'からして', false, 4),
-- Q46
(181, 46, 'に伴って', true, 1), (182, 46, 'を問わず', false, 2), (183, 46, 'どころか', false, 3), (184, 46, 'に反して', false, 4),
-- Q47
(185, 47, 'を問わず', true, 1), (186, 47, 'からして', false, 2), (187, 47, 'だけあって', false, 3), (188, 47, 'を契機に', false, 4),
-- Q48 (grammar N1)
(189, 48, '余儀なくされた', true, 1), (190, 48, 'べからずだ', false, 2), (191, 48, '極まりない', false, 3), (192, 48, 'に足る', false, 4),
-- Q49
(193, 49, '極まりない', true, 1), (194, 49, 'べからず', false, 2), (195, 49, 'を問わず', false, 3), (196, 49, 'に足る', false, 4),
-- Q50
(197, 50, 'きらい', true, 1), (198, 50, 'べから', false, 2), (199, 50, 'ながら', false, 3), (200, 50, 'わけ', false, 4);

-- =========================================================================
-- EXAMS (1 full mock exam per level, combining reading + listening + vocabulary + grammar)
-- =========================================================================
INSERT INTO exams (id, level, title, exam_type, skill_type, time_limit_minutes) VALUES
(1, 'N5', 'N5 総合模擬試験 サンプル', 'FULL_MOCK', NULL, 20),
(2, 'N4', 'N4 総合模擬試験 サンプル', 'FULL_MOCK', NULL, 25),
(3, 'N3', 'N3 総合模擬試験 サンプル', 'FULL_MOCK', NULL, 30),
(4, 'N2', 'N2 総合模擬試験 サンプル', 'FULL_MOCK', NULL, 35),
(5, 'N1', 'N1 総合模擬試験 サンプル', 'FULL_MOCK', NULL, 40);

INSERT INTO exam_questions (exam_id, question_id, display_order, points) VALUES
-- N5
(1, 1, 1, 1), (1, 2, 2, 1), (1, 11, 3, 1), (1, 12, 4, 1), (1, 21, 5, 1), (1, 22, 6, 1), (1, 23, 7, 1), (1, 36, 8, 1), (1, 37, 9, 1), (1, 38, 10, 1),
-- N4
(2, 3, 1, 1), (2, 4, 2, 1), (2, 13, 3, 1), (2, 14, 4, 1), (2, 24, 5, 1), (2, 25, 6, 1), (2, 26, 7, 1), (2, 39, 8, 1), (2, 40, 9, 1), (2, 41, 10, 1),
-- N3
(3, 5, 1, 1), (3, 6, 2, 1), (3, 15, 3, 1), (3, 16, 4, 1), (3, 27, 5, 1), (3, 28, 6, 1), (3, 29, 7, 1), (3, 42, 8, 1), (3, 43, 9, 1), (3, 44, 10, 1),
-- N2
(4, 7, 1, 1), (4, 8, 2, 1), (4, 17, 3, 1), (4, 18, 4, 1), (4, 30, 5, 1), (4, 31, 6, 1), (4, 32, 7, 1), (4, 45, 8, 1), (4, 46, 9, 1), (4, 47, 10, 1),
-- N1
(5, 9, 1, 1), (5, 10, 2, 1), (5, 19, 3, 1), (5, 20, 4, 1), (5, 33, 5, 1), (5, 34, 6, 1), (5, 35, 7, 1), (5, 48, 8, 1), (5, 49, 9, 1), (5, 50, 10, 1);

-- =========================================================================
-- Keep sequences in sync with the explicit ids inserted above
-- =========================================================================
SELECT setval(pg_get_serial_sequence('vocabulary_items', 'id'), (SELECT MAX(id) FROM vocabulary_items));
SELECT setval(pg_get_serial_sequence('kanji_items', 'id'), (SELECT MAX(id) FROM kanji_items));
SELECT setval(pg_get_serial_sequence('grammar_points', 'id'), (SELECT MAX(id) FROM grammar_points));
SELECT setval(pg_get_serial_sequence('passages', 'id'), (SELECT MAX(id) FROM passages));
SELECT setval(pg_get_serial_sequence('listening_audios', 'id'), (SELECT MAX(id) FROM listening_audios));
SELECT setval(pg_get_serial_sequence('questions', 'id'), (SELECT MAX(id) FROM questions));
SELECT setval(pg_get_serial_sequence('choices', 'id'), (SELECT MAX(id) FROM choices));
SELECT setval(pg_get_serial_sequence('exams', 'id'), (SELECT MAX(id) FROM exams));
SELECT setval(pg_get_serial_sequence('exam_questions', 'id'), (SELECT MAX(id) FROM exam_questions));
