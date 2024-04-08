import { PrismaClient } from "@prisma/client/edge";
import { withAccelerate } from "@prisma/extension-accelerate";
import { Hono, Handler } from "hono";
import { ProfileSchema } from "../schema_validation";
import { uoloadOnCloudinary } from "../util/cloudinary";
import multer from "multer";


type Bindings = {
    DATABASE_URL: string;

}

const profileRouter = new Hono<{
    Bindings: Bindings
}>()

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, './images');
    },
    filename: (req, file, cb) => {
        cb(null, file.originalname);
    }
});

const localFileSave = multer({ storage })

profileRouter.post('/create',localFileSave.fields([
    {
        name:'profile_image',
        maxCount: 1
    },
    {
        name: 'horoscope_img',
        maxCount: 1
    }
]) ,async (c) => {
    const prisma = new PrismaClient({
        datasourceUrl: c.env?.DATABASE_URL,
    }).$extends(withAccelerate());

    const body = await c.req.parseBody()
    console.log(body)
    const f1 = body["profile_image"]
    console.log(f1)


})
export default profileRouter
