require 'spec_helper'

describe ArticlesController do
  let(:admin_email) { APP_CONFIG[:admin_email] }
  let(:normal_user_email) { "normal_user@example.com" }

  shared_examples "permission control" do
    it "requrie admin" do
      expect(response).to redirect_to root_path
    end
  end

  describe "GET #index" do
    let!(:normal_article) { create :article }
    let!(:draft_article) { create :draft_article }

    shared_examples "for all user" do
      it "page title set to '首页'" do
        expect(assigns[:page_title]).to eq "首页"
      end

      it "render index page" do
        expect(response).to render_template :index
      end
    end

    shared_examples "for no or normal user sign in" do
      it "get @articles without draft tag" do
        expect(assigns[:articles]).to eq [normal_article]
      end
    end

    context "when no user sign in" do
      before { get :index }
  
      it_behaves_like "for all user"
      it_behaves_like "for no or normal user sign in"
    end

    context "when sign in with normal user" do
      before do
        set_user_session normal_user_email 
        get :index
      end

      it_behaves_like "for all user"
      it_behaves_like "for no or normal user sign in"
    end

    context "when sign in with admin" do
      before do
        set_user_session APP_CONFIG[:admin_email]
        get :index
      end

      it_behaves_like "for all user"

      it "get @articles with draft tag" do
        expect(assigns[:articles]).to eq [draft_article, normal_article]
      end
    end
  end

  describe "GET #new" do
    context "when no user sign in" do
      before { get :new }

      it_behaves_like "permission control"
    end

    context "when sign in with normal user" do
      before do
        set_user_session normal_user_email
        get :new
      end

      it_behaves_like "permission control"
    end

    context "when sign in with admin" do
      before do
        set_user_session APP_CONFIG[:admin_email]
        get :new
      end
        
      it "create new @article" do
        expect(assigns[:article]).to be_a_new(Article)
      end

      it "set page title to '发布文章'" do
        expect(assigns[:page_title]).to eq "发布文章"
      end

      it "render new page" do
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #create" do
    let(:article_attributes) { attributes_for :article }

    context "when no user sign in" do
      before { post :create, article: article_attributes }

      it_behaves_like "permission control"
    end

    context "when sign in with normal user" do
      before do
        set_user_session normal_user_email
        post :create, article: article_attributes
      end

      it_behaves_like "permission control"
    end

    context "when sign in with admin" do
      before do
        set_user_session APP_CONFIG[:admin_email]
      end

      context "with valid attributes" do
        it "save @article to database" do
          expect do
            post :create, article: article_attributes
          end.to change(Article, :count).by(1)
        end

        it "redirect to article path" do
          post :create, article: article_attributes
          expect(response).to redirect_to article_path(assigns[:article])
        end
      end

      context "with invalid attributes" do
        let(:invalid_attributes) { { title: "", content: "", tag_list: "" } }
        it "does not save article to database" do
          expect do
            post :create, article: invalid_attributes 
          end.to_not change(Article, :count)
        end

        it "re-render new page" do
          post :create, article: invalid_attributes
          expect(response).to render_template :new
        end
      end
    end
  end

  describe "GET #show" do
    let(:article) { create :article }
    let(:draft_article) { create :draft_article }

    shared_examples "for all user" do
      it "get @article" do
        expect(assigns[:article]).to eq article
      end

      it "set page title" do
        expect(assigns[:page_title]).to eq assigns[:article].title
      end

      it "render show page" do
        expect(response).to render_template :show
      end
    end

    shared_examples "for no or normal user login" do
      it "raise ActiveRecord::RecordNotFound error when show draft article" do
        expect do
          get :show, id: draft_article
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "when no user sign in" do
      before { get :show, id: article }

      it_behaves_like "for all user"
      it_behaves_like "for no or normal user login"
    end

    context "when sign in with normal user" do
      before do
        set_user_session normal_user_email
        get :show, id: article
      end
     
      it_behaves_like "for all user"
      it_behaves_like "for no or normal user login"
    end

    context "when sign in with admin" do
      context "show normal article" do
        before do
          set_user_session APP_CONFIG[:admin_email]
          get :show, id: article
        end

        it_behaves_like "for all user"
      end

      context "show draft article" do
        before do
          set_user_session APP_CONFIG[:admin_email]
          get :show, id: draft_article
        end

        it_behaves_like "for all user" do
          let(:article) { draft_article }
        end
      end
    end
  end

  describe "GET #edit" do
    let(:article) { create :article }

    context "when no user sign in" do
      before { get :edit, id: article }

      it_behaves_like "permission control"
    end

    context "when sign in with normal user" do
      before do
        set_user_session normal_user_email
        get :edit, id: article
      end

      it_behaves_like "permission control"
    end

    context "when sign in with admin" do
      before do
        set_user_session APP_CONFIG[:admin_email]
        get :edit, id: article
      end

      it "get @article" do
        expect(assigns[:article]).to eq article
      end

      it "set page title" do
        expect(assigns[:page_title]).to eq assigns[:article].title
      end

      it "render edit page" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "PATCH #update" do
    let!(:article) { create :article }
    let(:article_attributes) { {title: article.title,
                                content: article.content + "new added",
                                tag_list: article.tag_list} }

    context "when no user sign in" do
      before { patch :update, id: article, article: article_attributes }

      it_behaves_like "permission control"
    end

    context "when sign in with normal user" do
      before do
        set_user_session normal_user_email
        patch :update, id: article, article: article_attributes
      end

      it_behaves_like "permission control"
    end

    context "when sign in with admin" do
      before do
        set_user_session APP_CONFIG[:admin_email]
      end

      context "with valid attributes" do
        it "update article" do
          patch :update, id: article, article: article_attributes

          updated_article = assigns[:article].reload
          expect(updated_article.content).to eq article_attributes[:content]
        end

        it "redirect to article page" do
          patch :update, id: article, article: article_attributes

          expect(response).to redirect_to article_path(assigns[:article])
        end
      end

      context "with invalid attributes" do
        let(:article_attributes) { {title: "", 
                                    content: "",
                                    tag_list: ""} }
        it "dese not update article" do
          patch :update, id: article, article: article_attributes

          updated_article = assigns[:article].reload
          expect(updated_article.content).to_not eq article_attributes[:content]
        end

        it "re-render edit page" do
          patch :update, id: article, article: { title: '' }

          expect(response).to render_template :edit
        end
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:article) { create :article }

    context "when no user sign in" do
      before { delete :destroy, id: article }

      it_behaves_like "permission control" 
    end

    context "when sign in with normal user" do
      before do
        set_user_session normal_user_email
        delete :destroy, id: article
      end

      it_behaves_like "permission control"
    end

    context "when sign in with admin" do
      before do
        set_user_session APP_CONFIG[:admin_email]
      end

      it "destroy @article" do
        expect do
          delete :destroy, id: article
        end.to change(Article, :count).by(-1)
      end

      it "redirect to articles path" do
        delete :destroy, id: article

        expect(response).to redirect_to articles_path
      end
    end
  end

  describe "GET #tagging" do
    let!(:article) { create :article }
    let!(:draft_article) { create :draft_article }

    shared_examples "for all user" do
      it "set page title" do
        get :tagging, tag: tag_name
        expect(assigns[:page_title]).to eq "#{tag_name} 相关文章"
      end
      
      it "set @articles when tag is not 'draft'" do
        get :tagging, tag: tag_name
        expect(assigns[:articles]).to eq [article]
      end

      it "render index" do
        get :tagging, tag: tag_name
        expect(response).to render_template :index
      end
    end

    shared_examples "for no or normal user login" do
      it "set @articles to empty array when tag is 'draft'" do
        expect do
          get :tagging, tag: 'draft'
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "when no user login" do
      it_behaves_like "for all user" do
        let(:tag_name) { article.tags[0].name }
      end
      it_behaves_like "for no or normal user login"
    end

    context "when sign in with normal user" do
      before { set_user_session normal_user_email }

      it_behaves_like "for all user" do
        let(:tag_name) { article.tags[0].name }
      end
      it_behaves_like "for no or normal user login"
    end

    context "when sign in with admin" do
      before { set_user_session admin_email }

      it_behaves_like "for all user" do
        let(:tag_name) { article.tags[0].name }
      end

      it "set @articles when tag is 'draft'" do
        get :tagging, tag: 'draft'

        expect(assigns[:articles]).to eq [draft_article]
      end
    end
  end
end
