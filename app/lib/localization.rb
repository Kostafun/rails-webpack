module Localization

  def set_locale
    I18n.locale = extract_locale_from_subdomain || http_accept_language.compatible_language_from(I18n.available_locales) || I18n.default_locale
  end

  def extract_locale_from_subdomain
    I18n.available_locales.map(&:to_s).include?(get_lang_from_subdomain) ? get_lang_from_subdomain : nil
  end

  def get_lang_from_subdomain
    if match = request.url.match(/http:\/\/(www.)?(?<lang>[a-z][a-z])\./i)
      match.captures[0]
    end
  end

  def switch_to(switch_to_lang)
    request.url.gsub(/http(?<s>s?):\/\/(www.)?([a-z][a-z]\.)?/i, 'http\k<s>://'+switch_to_lang+'.')
  end

end


