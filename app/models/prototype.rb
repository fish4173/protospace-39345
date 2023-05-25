class Prototype < ApplicationRecord

  # テーブルとのアソシエーション
  has_many :comments
  belongs_to :user
  has_one_attached :image #画像ファイルとの1対1の紐づけ

  #バリテーション必須項目の選択と制限
  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :image, presence: true

end
