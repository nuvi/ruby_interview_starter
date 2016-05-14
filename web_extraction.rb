require_relative './file_extraction'

class WebFetcher
  def initialize(site_url, download_path)
    @site_url = site_url
    @download_path = download_path
  end  

  def get_zip_files
    # WARNING: this took my computer 15 hours to complete. Granted my computer is older than the pyramids of Giza
    `wget -r -l 1 -A zip -nd #{@site_url} -P #{@download_path}`
  end  
end  

web_fetcher = WebFetcher.new('http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/', 'test/files/downloads')

# web_fetcher.save_zip_files_to_downloads_folder
web_fetcher.get_zip_files
# web_fetcher.remove_from_nested_folder