#second= I18n::Backend::Simple.new
#I18n::Backend::Simple.send(:include, I18n::Backend::Memoize)
#I18n.backend = second


require 'i18n/backend/active_record'

  first = I18n::Backend::ActiveRecord.new
  second= I18n::Backend::Simple.new

  I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Memoize)
  I18n::Backend::ActiveRecord.send(:include, I18n::Backend::Flatten)
  I18n::Backend::Simple.send(:include, I18n::Backend::Memoize)
  #I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)

  I18n.backend = I18n::Backend::Chain.new(first, second)

