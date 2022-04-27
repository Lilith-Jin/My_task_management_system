class Task < ApplicationRecord
    enum priority:{"高": 1, "中": 2, "低": 3 },_default: "高"
    enum status:{"待處理": 1, "進行中": 2, "已完成": 3 },_default: "待處理"
end
