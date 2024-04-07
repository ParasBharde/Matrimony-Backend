import { PrismaClient } from "@prisma/client/edge";
import { withAccelerate } from "@prisma/extension-accelerate";
import { Hono } from "hono";
import { ProfileSchema } from "../schema_validation";

const profileRouter = new Hono<{
    Bindings:{
        DATABASE_URL: string,
        CLOUDINARY_CLOUDNAME:string
    }
}>()

profileRouter.get('/', async (c) => {
    return c.json(c.env?.CLOUDINARY_CLOUDNAME)

})

profileRouter.post('/create', async (c) => {
    
    const prisma = new PrismaClient({
        datasourceUrl: c.env?.DATABASE_URL
    }).$extends(withAccelerate());

    const body = c.req.json()
    const {success} = ProfileSchema.safeParse(body);
    console.log(body, success)
});


export default profileRouter


