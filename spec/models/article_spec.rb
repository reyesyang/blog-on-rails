require 'spec_helper'

describe Article do
  before(:each) do
    @article = create :article
  end

  context 'validation' do
    it 'is valide' do
      expect(@article).to be_valid
    end

    it 'is invalid when title is empty' do
      @article.title = ''
      expect(@article).to be_invalid 
    end

    it 'is invalid when content is empty' do
      @article.content = ''
      expect(@article).to be_invalid
    end

    it 'is invalid when title have been used' do
      article = build :article, title: @article.title
      expect(article).to be_invalid
    end

    it 'is invalid when content length less than 20' do
      @article.content = 'a' * 19
      expect(@article).to be_invalid
    end
  end

  describe '#tag_list' do
    context "assign to default value 'tag1,tag2'" do
      it 'created two tags' do
        expect(Tag.count).to eq 2
        tags = Tag.pluck :name
        expect(tags).to include 'tag1'
        expect(tags).to include 'tag2'
      end

      it "tag1's articles_count should be 1" do
        tag1 = Tag.find_by_name 'tag1'
        expect(tag1.articles_count).to eq 1
      end

      it "tag2's articles_count should be 1" do
        tag2 = Tag.find_by_name 'tag2'
        expect(tag2.articles_count).to eq 1
      end
    end

    context "change value to 'tag1'" do
      before(:each) do
        @article.tag_list = "tag1"
        @article.save
      end

      it "tags' count is 2" do
        expect(Tag.count).to eq 2
      end

      it "tag1's articles_count is 1" do
        tag1 = Tag.find_by_name "tag1"
        expect(tag1.articles_count).to eq 1
      end

      it "tag2's articles_count is 0" do
        tag2 = Tag.find_by_name "tag2"
        expect(tag2.articles_count).to be 0
      end
    end

    context "change value to 'tag2,tag3'" do
      before(:each) do
        @article.tag_list = "tag2,tag3"
        @article.save
      end

      it "tag's count is 3" do
        expect(Tag.count).to eq 3
      end

      it "tag1's articles_count is 0 " do
        tag1 = Tag.find_by_name "tag1"
        expect(tag1.articles_count).to eq 0
      end

      it "tag2's articles_count is 1" do
        tag2 = Tag.find_by_name "tag2"
        expect(tag2.articles_count).to eq 1
      end

      it "tag3's articles_count is 1" do
        tag3 = Tag.find_by_name "tag3"
        expect(tag3.articles_count).to eq 1
      end
    end
  end

  describe '#draft?' do
    it "return false when tags exclude 'draft'" do
      expect(@article).not_to be_draft
    end

    context "change tag_list value to 'tag1,draft'" do
      before(:each) do
        @article.tag_list = "tag1,draft"
        @article.save
      end

      it "Tag's count is 3" do
        expect(Tag.count).to eq 3
      end

      it "tag1's articles_count is 0" do
        tag1 = Tag.find_by_name "tag1"
        expect(tag1.articles_count).to eq 0
      end

      it "tag2's articles_count is 0" do
        tag2 = Tag.find_by_name "tag2"
        expect(tag2.articles_count).to eq 0
      end

      it "draft's articles_count is 1" do
        draft = Tag.find_by_name "draft"
        expect(draft.articles_count).to eq 1
      end

      it "return true when tags include 'draft'" do
        expect(@article).to be_draft
      end
    end

    
  end
end
