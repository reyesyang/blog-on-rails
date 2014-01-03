require 'spec_helper'

feature "Articles" do
  given(:admin_email) { APP_CONFIG[:admin_email] }
  given(:normal_user_email) { 'normal_user@example.com' }

  scenario "Anonymous user should not see draft articles", js: true do
    article = create :article
    draft_article = create :draft_article

    visit root_path

    expect(page).to have_content article.title
    article.tags.each do |tag|
      expect(page).to have_link tag.name
    end

    expect(page).to_not have_content draft_article.title
    expect(page).to_not have_link 'draft'

    click_link article.title
    expect(page).to_not have_link 'draft'
  end

  scenario "Normal user should not see draft articles", js: true do
    article = create :article
    draft_article = create :draft_article

    sign_in normal_user_email

    expect(page).to have_content article.title
    article.tags.each do |tag|
      expect(page).to have_link tag.name
    end

    expect(page).to_not have_content draft_article.title
    expect(page).to_not have_link 'draft'

    click_link article.title
    expect(page).to_not have_link 'draft'
  end

  scenario "Admin user should see draft articles", js: true do
    article = create :article
    draft_article = create :draft_article

    sign_in admin_email

    expect(page).to have_content article.title
    article.tags.each do |tag|
      expect(page).to have_link tag.name
    end

    expect(page).to have_content draft_article.title
    expect(page).to have_link 'draft'

    click_link article.title
    expect(page).to have_link 'draft'
  end
  
  scenario "Anonymous user should not see article operation links", js: true do
    article = create :article
    draft_article = create :draft_article

    visit root_path

    expect(page).to_not have_link '现在就发表一篇'
    expect(page).to_not have_link '编辑'
    expect(page).to_not have_link '删除'

    click_link article.title
    expect(page).to_not have_link '编辑'
    expect(page).to_not have_link '删除'
  end
  
  scenario "Normal user should not see article operation links", js: true do
    article = create :article
    draft_article = create :draft_article

    sign_in normal_user_email

    expect(page).to_not have_link '现在就发表一篇'
    expect(page).to_not have_link '编辑'
    expect(page).to_not have_link '删除'

    click_link article.title
    expect(page).to_not have_link '编辑'
    expect(page).to_not have_link '删除'
  end
  
  scenario "Admin user should see article operation links", js: true do
    article = create :article
    draft_article = create :draft_article

    sign_in admin_email

    expect(page).to have_link '现在就发表一篇'
    expect(page).to have_link '编辑'
    expect(page).to have_link '删除'

    click_link article.title
    expect(page).to have_link '编辑'
    expect(page).to have_link '删除'
  end

  scenario "Admin post a new article", js: true do
    sign_in APP_CONFIG[:admin_email]
    click_link "现在就发表一篇"

    sleep 1
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
  end

  scenario "Admin edit a exist article", js: true do
    article = create :article

    sign_in APP_CONFIG[:admin_email]
    click_link article.title
    sleep 1
    expect(current_path).to eq article_path(article)

    click_link "编辑"
    sleep 1
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
  end

  scenario "Admin delete a exist article", js: true do
    article = create :article

    sign_in APP_CONFIG[:admin_email]
    click_link article.title
    sleep 1
    expect(current_path).to eq article_path(article)

    click_link "删除"

    confirm = page.driver.browser.switch_to.alert
    confirm.accept

    expect(current_path).to eq articles_path
  end
end
