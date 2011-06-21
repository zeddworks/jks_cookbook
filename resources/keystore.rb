def initialize(*args)
    super
    @action = :create
end

actions :create

attribute :subject, :kind_of => String, :name_attribute => true
attribute :cn_alias, :kind_of => String
attribute :ca_url, :kind_of => String
attribute :ca_user, :kind_of => String
attribute :ca_pass, :kind_of => String
attribute :store_pass, :kind_of => String
attribute :user_agent, :kind_of => String
attribute :jks_path, :kind_of => String
