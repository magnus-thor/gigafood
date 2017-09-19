ActiveAdmin.register Translation, as: 'Translation' do
  menu parent: 'Admin', priority: 3, label: 'Translations'
  permit_params :locale, :key, :value, :interpolations, :is_proc

  index do
    selectable_column
    column :locale
    column :key
    column :value
    actions
  end

  show do
    attributes_table do
      row :key
      row :value
      row :locale
    end
  end

  form do |f|
    f.inputs do
      f.input :locale, label: 'Language', as: :select, collection: LANGUAGES, include_blank: false
      f.input :key, as: :select, collection: I18n.get_current_locale_keys, include_blank: false
      f.input :value
      f.actions
    end
  end
end
