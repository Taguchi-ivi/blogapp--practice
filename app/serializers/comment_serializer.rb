class CommentSerializer < ActiveModel::Serializer
  # 出力する情報を限定する
  attributes :id, :content
end
