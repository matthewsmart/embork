require 'embork/sprockets/helpers'
require 'embork/borkfile'

class Embork::Extension
  attr_reader :project_root

  def initialize(project_root, bundled_assets: false, environment: nil)
    @environment = environment || Embork.env || ENV['RACK_ENV']
    @project_root = project_root
    if bundled_assets
      version_file_path = File.join(project_root, 'build',
                                    @environment.to_s, 'current-version')
      @bundle_version = File.read(version_file_path)
      @use_bundled_assets = true
    end
  end

  def helpers
    helpers = Embork::Sprockets::Helpers
    if @use_bundled_assets
      helpers.bundle_version = @bundle_version
      helpers.use_bundled_assets = @use_bundled_assets
    end
    helpers
  end

end