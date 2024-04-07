import multer from 'multer'

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "./.wrangler/temp")
    },
    filename: function (req, file, callback) {
        
        callback(null,file.originalname);
    }
})

export const upload = multer({storage})
