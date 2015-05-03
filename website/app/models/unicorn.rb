class Unicorn < ActiveRecord::Base
    # This paperclip-supplied method associates the attribute ":image" with a file attachment
    has_attached_file :image,
        styles: {
        thumb: '100x100>',
        medium: '300x300>'
        },
        :source_file_options => { :all => '-auto-orient' }

    after_image_post_process :process_image_on_upload

    # Validate the attached image is image/jpg, image/png, etc
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

    def process_image_on_upload
        # get location information

        puts "Processing image..."

        exif = EXIFR::JPEG.new(image.queued_for_write[:original].path)
        return unless exif && exif.gps
        
        self.latitude = exif.gps.latitude
        self.longitude = exif.gps.longitude

        puts "  gps: #{self.latitude}, #{self.longitude}"
    end

    def self.get_geojson server_url
        #
        # A first pass at wrapping up data we'll want to display unicorn markers on
        # map.  I'm using a simple GeoJSON structure because that is supported by MapBox.
        # It seems like we'll probably want to ask for this for some geographic area.
        #
        geojson = { type: "FeatureCollection", features: [] }
        Unicorn::all.each do |u|
            puts "processing unicorn #{u.id}"
            feature = { 
                type: "Feature",
                geometry: {
                    type: "Point",
                    coordinates: [ u.longitude, u.latitude ]
                },
                properties: {
                    title: 'unicorn sighting',
                    description: 'blah blah',
                    date: u.created_at.strftime( "%m/%d/%Y" ),
                    #'marker-size' => 'large',
                    'marker-color' => '#329AF6',
                    #'marker-symbol' => 'marker',
                    image_thumb: u.image.url(:thumb),
                    image_medium: u.image.url(:medium),
                    #
                    # It seems wasteful to send down this same icon with every unicorn.  The map should
                    # get this data once and reuse it.
                    #
                    icon: {
                        iconUrl: ActionController::Base.helpers.asset_path("unicorn_icon40x49.png"),
                        iconSize: [40,49],
                        iconAnchor: [20,25],
                        popupAnchor: [-8,-18 ],
                        className: "dot"
                    }
                }
            }
            puts "  icon is: #{feature[:properties][:icon].inspect}"
            geojson[ :features ] << feature
        end
        geojson
    end
end