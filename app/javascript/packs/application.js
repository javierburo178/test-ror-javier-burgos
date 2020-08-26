// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import 'bootstrap'
import '../stylesheets/application'


require("jquery")
require("jquery-jcrop")
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require("trix")
require("@rails/actiontext")

document.addEventListener("turbolinks:load", () => {
    $('[data-toggle="tooltip"]').tooltip()
})



jQuery(() => new PostCropper());

class PostCropper {
    constructor() {
        this.update = this.update.bind(this);
        this.updatePreview = this.updatePreview.bind(this);
        $('#cropbox').Jcrop({
            aspectRatio: 1,
            setSelect: [0, 0, 600, 600],
            onSelect: this.update,
            onChange: this.update
        });
    }

    update(coords) {
        $('#post_crop_x').val(coords.x);
        $('#post_crop_y').val(coords.y);
        $('#post_crop_w').val(coords.w);
        $('#post_crop_h').val(coords.h);
        console.log($('#post_crop_x').val(coords.x))
        return this.updatePreview(coords);
    }

    updatePreview(coords) {
        return $('#preview').css({
            width: Math.round((100/coords.w) * $('#cropbox').width()) + 'px',
            height: Math.round((100/coords.h) * $('#cropbox').height()) + 'px',
            marginLeft: `-${Math.round((100/coords.w) * coords.x)}px`,
            marginTop: `-${Math.round((100/coords.h) * coords.y)}px`
        });
    }
}



