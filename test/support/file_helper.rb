module FileHelper
  class << self
    def pdf
      File.open(Dir[path_to_folder('pdfs')].sample)
    end

    def image
      File.open(Dir[path_to_folder('images')].sample)
    end

    def csv(name = nil)
      return File.open(Dir[path_to_folder('csv')].sample) unless name

      File.open(path_to_file("csv/#{name}.csv"))
    end

    private

    def path_to_folder(folder)
      "#{base_path}/#{folder}/*"
    end

    def path_to_file(file)
      "#{base_path}/#{file}"
    end

    def base_path
      ENV['FILES_PATH_TO_TEST'] || Rails.root.join('test/samples')
    end
  end
end
