require 'spec_helper'

feature "Articles" do
  scenario "Post a new article", js: true do
    sign_in APP_CONFIG[:admin_email]
    click_link "现在就发表一篇" 
    expect(current_path).to eq new_article_path

    article = build :article
    within(".new_article") do
      fill_in "article[title]", with: article.title
      fill_in "article[tag_list]", with: article.tag_list
      fill_in "article[content]", with: article.content
    end
    click_button "发表文章"

    article = Article.last
    expect(current_path).to eq article_path(article)
    expect(page).to have_content article.title
    article.tags.pluck(:name).each do |tag_name|
      expect(page).to have_content tag_name
    end
    expect(page).to have_content article.content

    sign_out
  end


  scenario "Edit a exist article", js: true do
    article = create :article

    sign_in APP_CONFIG[:admin_email]
    click_link article.title
    expect(current_path).to eq article_path(article)

    click_link "编辑"
    expect(current_path).to eq edit_article_path(article)
    
    within(".edit_article") do
      fill_in "article[title]", with: article.title + "new"
      fill_in "article[tag_list]", with: article.tag_list + ",tag3"
      fill_in "article[content]", with: article.content + "new"
    end
    click_button "发表文章"

    expect(current_path).to eq article_path(article.reload)
    expect(page).to have_content article.title
    article.tags.pluck(:name).each do |tag_name|
      expect(page).to have_content tag_name
    end
    expect(page).to have_content article.content

    sign_out
  end

  scenario "Delete a exist article", js: true do
    article = create :article

    sign_in APP_CONFIG[:admin_email]
    click_link article.title
    expect(current_path).to eq article_path(article)

    click_link "删除"

    confirm = page.driver.browser.switch_to.alert
    confirm.accept

    expect(current_path).to eq articles_path

    sign_out
  end
end
