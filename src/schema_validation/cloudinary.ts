import { v2 as cloudinary } from 'cloudinary';
import fs from "fs";
import { env } from 'process';


cloudinary.config({
    cloud_name: env.CLOUDINARY_NAME,
    api_key: env.CLOUDINARY_API_KEY,
    api_secret: env.CLOUDINARY_API_SECRET
})

const uoloadOnCloudinary = async (localFilePath: any) => {
    try {
        if (!localFilePath) return null
        const uploaded = await cloudinary.uploader.upload(localFilePath, {
            resource_type: "auto"
        })
        console.log('File Uploaded URL', uploaded.url)

        console.log('File Uploaded', uploaded)
        return uploaded;
    } catch (e) {
        fs.unlinkSync(localFilePath);
        return null
    }
}


export {uoloadOnCloudinary}
