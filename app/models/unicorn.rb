class Unicorn < ActiveRecord::Base
    # This paperclip-supplied method associates the attribute ":image" with a file attachment
    has_attached_file :image,
        styles: {
        thumb: '100x100>',
        medium: '500x500>'
        },
        :source_file_options => { :all => '-auto-orient' }

    after_image_post_process :process_image

    # Validate the attached image is image/jpg, image/png, etc
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

    def process_image
        # get location information

        puts "Processing image..."

        exif = EXIFR::JPEG.new(image.queued_for_write[:original].path)
        return unless exif
        
        self.latitude = exif.gps.latitude
        self.longitude = exif.gps.longitude

        puts "  gps: #{self.latitude}, #{self.longitude}"
    end
end