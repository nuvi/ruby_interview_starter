require_relative './download_reader'
require_relative './web_extraction'

class FetchAndSave
  def initialize(download_dir, extraction_dir, site_url)
    @web_fetcher = WebFetcher.new(site_url, download_dir)
    @download_reader = DownloadReader.new(download_dir, extraction_dir)
  end  

  def web_fetch
    @web_fetcher.get_zip_files
  end
  
  def save_to_redis
    @download_reader.unzip_all_files
    @download_reader.save_to_redis
  end

  def fetch_and_save
    web_fetch
    save_to_redis
  end  
end  