unless Rails.env.production?
  require "haml_lint/rake_task"
  require "rubocop/rake_task"
  require "scss_lint/rake_task"

  namespace :lint do
    HamlLint::RakeTask.new do |t|
      t.config = ".haml-lint.yml"
      t.files = ["app/views"]
    end

    RuboCop::RakeTask.new(:rubocop)

    SCSSLint::RakeTask.new do |t|
      t.config = ".scss-lint.yml"
      t.files = ["frontend/css"]
    end

    desc "run `npm run lint`"
    task :js do
      system! "npm run lint"
    end
  end

  desc "Runs all linters across the repository"
  task lint: %i(lint:haml_lint lint:rubocop lint:scss_lint lint:js)
end
