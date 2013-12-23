require 'spec_helper'

feature "Psersona" do
  scenario "sign in and sign out", js: true do
    visit root_path
    sign_in APP_CONFIG["admin_email"]
    expect(page).to have_content "退出"

    sign_out
    expect(page).to have_content "登录"
  end
end
