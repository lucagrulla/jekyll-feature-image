module Jekyll
  class FeatureImageTag < Liquid::Tag

    def initialize(tag_name, image, tokens)
      super
      @image = image.strip
    end

    def render(context)
      env =  context.environments.first
      images_base_path = env["site"]["image_folder"]
      images_base_path =  images_base_path + "/" if !images_base_path.end_with?("/")

      warn "you have to define the image_base_path in th configuration file" if images_base_path.nil?

      image_path = images_base_path << env["page"]["categories"].join("/") << "/"
      image_path = env["page"][@image].nil? ? env["site"]["default_feature_image"] : image_path << env["page"][@image]
      image_path =  "/" << image_path if !image_path.start_with?("/")

      image_path.nil? ? "" : "<img src='#{image_path}' title='' alt=''/>"
     
    end
  end
end

Liquid::Template.register_tag('featureImage', Jekyll::FeatureImageTag)