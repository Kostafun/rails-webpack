module WebpackAssets
  def assets_hash
    @assets_json = JSON.parse(File.read('public/js/assets.json'))
  end
  def script_for(bundle)
    @assets_json[bundle]['js']
  end

  def style_for(bundle)
    @assets_json[bundle]['css']
  end

end