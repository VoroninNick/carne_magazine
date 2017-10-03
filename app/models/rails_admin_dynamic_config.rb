module RailsAdminDynamicConfig
  class << self
    def configure_rails_admin(initial = true)
      RailsAdmin.config do |config|

        ### Popular gems integration

        ## == Devise ==
        config.authenticate_with do
          warden.authenticate! scope: :user
        end
        config.current_user_method(&:current_user)

        ## == Cancan ==
        #config.authorize_with :cancan

        ## == Pundit ==
        # config.authorize_with :pundit

        ## == PaperTrail ==
        # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

        ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration



        if initial
          config.actions do
            dashboard                     # mandatory
            index                         # mandatory
            new do
              #except [CallRequest, ConsultationRequest, MeterRequest, ContactsRequest, PartnershipRequest]
            end
            export
            bulk_delete
            show
            edit
            delete
            show_in_app
            props do
              only []
            end
            #edit_model
            nestable do
              only [Cms::Page]
            end

            ## With an audit adapter, you can add:
            # history_index
            # history_show
          end


          config.parent_controller = "ApplicationController"
        end

        config.navigation_labels do
          {
            feedbacks: 100,
            home: 200,
            about_us: 300,
            video: 320,
            promotions: 340,
            projects: 400,
            faq: 700,
            contacts: 800,
            terms_of_use: 850,
            tags: 1000,
            users: 1100,
            settings: 1200,
            pages: 1300,
            assets: 1400
          }
        end

        config.navigation_static_links = {
           mailchimp: "/admin/mailchimp",
           locales: "/file_editor/locales",
           site_data: "/file_editor/site_data.yml"
        }


        #
        #
        config.include_models Cms::SitemapElement, Cms::MetaTags
        config.include_models Cms::Page
        config.model Cms::Page do
          navigation_label_key(:pages, 1)
          nestable_list({position_field: :sorting_position, scope: :order_by_sorting_position})
          object_label_method do
            :custom_name
            #{
            #k = @bindings[:object].type.underscore.split("/").last
            #I18n.t("activerecord.models.pages.#{k}", raise: true) rescue k.humanize
            #}
          end
          list do
            sort_by do
              "sorting_position"
            end

            field :name do
              def value
                k = @bindings[:object].type.underscore.split("/").last
                I18n.t("activerecord.models.pages.#{k}", raise: true) rescue k.humanize
              end
            end

            field :h1_text do
              def value
                @bindings[:object].h1_text
              end
            end
          end

          edit do
            field :name do
              read_only true
              def value
                k = @bindings[:object].type.underscore.split("/").last
                I18n.t("activerecord.models.pages.#{k}", raise: true) rescue k.humanize
              end
            end
            field :translations, :globalize_tabs
            field :seo_tags

          end

        end

        config.model_translation Cms::Page do
          field :locale, :hidden
          field :h1_text
        end


        config.model Cms::MetaTags do
          visible false
          field :translations, :globalize_tabs
        end

        config.model_translation Cms::MetaTags do
          field :locale, :hidden
          field :title
          field :keywords
          field :description
        end


        config.model Cms::SitemapElement do
          visible false

          field :display_on_sitemap
          field :changefreq
          field :priority
        end

        config.include_models Attachable::Asset

        config.model Attachable::Asset do
          navigation_label_key(:assets, 1)
          field :data
          #watermark_position_field(:data)
          field :sorting_position
          field :translations, :globalize_tabs
        end

        config.model_translation Attachable::Asset do
          field :locale, :hidden
          field :data_alt
        end


        config.include_models User
        config.model User do
          navigation_label_key(:users, 1)
          field :email
          field :password
          field :password_confirmation
        end

        config.include_models Cms::Tag, Cms::Tagging

        config.model Cms::Tag do
          navigation_label_key(:tags, 1)
          field :translations, :globalize_tabs
          field :videos
        end

        config.model_translation Cms::Tag do
          field :locale, :hidden
          field :name
          field :url_fragment do
            help do
              I18n.t("admin.help.#{name}")
            end
          end
        end

        config.model Cms::Tagging do
          visible false
        end

        # ===================================================
        # Requests
        # ===================================================
        #config.configure_forms(ContactRequest)

        # ===================================================
        # Application specific models
        # ===================================================
        config.include_models Article, ArticleCategory

        config.model Article do
          navigation_label_key(:articles, 1)

          field :published
          field :article_category
          field :translations, :globalize_tabs
          field :image
          field :release_date do
            date_format do
              :short
            end
          end
          field :seo_tags
        end

        config.model_translation Article do
          field :locale, :hidden
          field :name
          field :url_fragment
          field :author_name
          field :author_description
          field :content, :ck_editor
        end

        config.model ArticleCategory do
          navigation_label_key(:articles, 2)
          nestable_list({position_field: :sorting_position})

          field :translations, :globalize_tabs
        end

        config.model_translation ArticleCategory do
          field :locale, :hidden
          field :name
          field :url_fragment
        end


      end
    end
  end
end