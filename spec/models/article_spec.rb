require 'spec_helper'

describe Article do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
    it { should validate_uniqueness_of :title }
    it { should ensure_length_of(:content).is_at_least(20) }
  end

  describe "assosiations" do
    it { should have_many :taggings }
    it { should have_many :tags }

    it "touch related tag when destroy a article" do
      article = create :article, tag_list: 'tag1'
      tag = Tag.find_by_name 'tag1'
      tag_articles_count = tag.articles_count
      tag_updated_at = tag.updated_at

      sleep 1
      article.destroy
      expect(tag.reload.articles_count).to eq (tag_articles_count - 1)
      expect(tag.updated_at).to be > tag_updated_at
    end

    it "touch related article and tag when edit a article's tag_list" do
      article = create :article, tag_list: 'tag1,tag2'
      article_updated_at = article.updated_at
      tag = Tag.find_by_name 'tag2'
      tag_articles_count = tag.articles_count
      tag_updated_at = tag.updated_at

      sleep 1
      article.update_attribute :tag_list, 'tag1'
      expect(article.reload.updated_at).to be > article_updated_at
      expect(tag.reload.articles_count).to eq (tag_articles_count - 1)
      expect(tag.updated_at).to be > tag_updated_at
    end
  end

  describe '#tag_list' do
    subject!(:article) { create :article, tag_list: 'tag1,tag2' }

    context "assign to default value 'tag1,tag2'" do
      it "Tag's count is 2" do
        expect(Tag.count).to eq 2
      end

      its("tags.count") { should eq 2  }

      it "tag1's articles_count is 1" do
        tag = article.tags.find_by_name 'tag1'
        expect(tag.articles_count).to eq 1
      end

      it "tag2's articles_count is 1" do
        tag = article.tags.find_by_name 'tag2'
        expect(tag.articles_count).to eq 1
      end
    end

    context "change value to 'tag1'" do
      before(:each) do
        article.update_attribute :tag_list, "tag1"
      end

      it "Tag's count is 2" do
        expect(Tag.count).to eq 2
      end

      its("tags.count") { should eq 1 }

      it "tag1's articles_count is 1" do
        tag = article.tags.find_by_name "tag1"
        expect(tag.articles_count).to eq 1
      end

      it "tagging for tag2 have been deleted" do
        tag = article.tags.find_by_name "tag2"
        expect(tag).to be_nil
      end

      it "tag2's articles_count is 0" do
        tag = Tag.find_by_name "tag2"
        expect(tag.articles_count).to be 0
      end
    end

    context "change value to 'tag2,tag3'" do
      before(:each) do
        article.update_attribute :tag_list, "tag2,tag3"
      end

      it "Tag's count is 3" do
        expect(Tag.count).to eq 3
      end

      its("tags.count") { should eq 2 }

      it "tagging for tag1 have been deleted" do
        tag = article.tags.find_by_name "tag1"
        expect(tag).to be_nil
      end

      it "tag1's articles_count is 0 " do
        tag = Tag.find_by_name "tag1"
        expect(tag.articles_count).to eq 0
      end

      it "tag2's articles_count is 1" do
        tag = article.tags.find_by_name "tag2"
        expect(tag.articles_count).to eq 1
      end

      it "tag3's articles_count is 1" do
        tag = article.tags.find_by_name "tag3"
        expect(tag.articles_count).to eq 1
      end
    end
  end

  describe '#draft?' do
    context "tag_list without 'draft'" do
      subject { create :article }

      it { should_not be_draft }
    end

    context "tag_list value with 'draft'" do
      subject(:article) { create :article, tag_list: 'tag1,draft' }

      it "Tag's count is 1" do
        expect(article.tags.count).to eq 1
      end

      it "draft tag's articles_count is 1" do
        tag = article.tags.find_by_name "draft"
        expect(tag.articles_count).to eq 1
      end

      it { should be_draft }
    end
  end

  describe "published scope" do
    it "return articles without tagged with 'draft'" do
      normal_article = create :article
      draft_article = create :article, tag_list: "draft"

      expect(Article.published).to eq [normal_article]
    end
  end
end
