require "fnv"

module IdentityUtils

  # URIからIDを作る
  def id
    # 軽いと噂のFNV1ハッシュ関数
    @fnv ||= FNV.new
    @fnv.fnv1a_64(self.uri)
  end
end

# ユーザーモデル
class DonUser < Retriever::Model
  include Retriever::Model::UserMixin
  include Retriever::Model::Identity
  include IdentityUtils

  register(:don_user, name: Plugin[:"mikutter丼"]._("Mastodon"))

  field.string(:idname, required: true)
  field.string(:name, required: true)
  field.string(:uri, required: true)
  field.string(:profile_image_url, required: true)
end

# メッセージモデル
class DonMessage < Retriever::Model
  include Retriever::Model::MessageMixin
  include Retriever::Model::Identity
  include IdentityUtils

  register(:don_message, name: Plugin[:"mikutter丼"]._("Mastodon"))

  field.string(:description, required: false)
  field.time(:created, required: false)
  field.string(:uri, required: true)
  field.has(:user, DonUser, required: true)

  entity_class Retriever::Entity::ExtendedTwitterEntity
end

