import { MiddlewareHandler} from 'hono';
import multer from 'multer'

// Define multer storage configuration
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "./.wrangler/temp");
    },
    filename: (req, file, cb) => {
        cb(null, file.originalname);
    }
});

// Create multer middleware to handle file uploads
export const multerUploadMiddleware = multer({ storage })



