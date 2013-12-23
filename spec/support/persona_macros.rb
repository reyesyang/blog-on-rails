module PersonaMacros
  def set_user_session(user_email)
    session[:email] = user_email
  end

  def sign_in(email)
    require 'fakeweb'

    visit root_path
    FakeWeb.register_uri(:post, "https://verifier.login.persona.org/verify",
                         body: { status: "okay", email: email }.to_json,
                         status: ["200", "OK"])

    click_link '登录'

    alert = page.driver.browser.switch_to.alert
    alert.send_keys email
    alert.accept
    #page.driver.js_prompt_input = email
    #page.driver.accept_js_prompts!
  end

  def sign_out
    click_link "退出"

    alert = page.driver.browser.switch_to.alert
    alert.accept
    # page.driver.accept_js_comfirms!
  end
end
