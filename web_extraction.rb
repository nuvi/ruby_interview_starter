require 'redis'
class WebFetcher
  def initialize(site_url, download_path)
    @site_url = site_url
    @download_path = download_path
  end  

  def get_zip_files
    `wget -r -l 1 -A zip -nd Q50m #{@site_url} -P #{@download_path}`
  end  
end  

