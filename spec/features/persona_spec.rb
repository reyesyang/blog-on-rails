require 'spec_helper'

feature "Psersona" do
  scenario "sign in and sign out", js: true do
    visit root_path
    sign_in APP_CONFIG["admin_email"]
    expect(page).to have_link "退出"

    sign_out
    expect(page).to have_link "登录"
  end

  scenario "cancel sign out", js: true do
    visit root_path
    sign_in APP_CONFIG["admin_email"]
    
    click_link "退出"
    alert = page.driver.browser.switch_to.alert
    alert.dismiss

    expect(page).to have_link "退出"
  end
end
