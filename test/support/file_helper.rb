module FileHelper
  class << self
    def pdf
      File.open(Dir[path_to('pdfs')].sample)
    end

    def image
      File.open(Dir[path_to('images')].sample)
    end

    private

    def path_to(folder)
      base = ENV['FILES_PATH_TO_TEST'] || Rails.root.join('test/samples')

      "#{base}/#{folder}/*"
    end
  end
end
