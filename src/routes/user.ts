import { PrismaClient } from "@prisma/client/edge";
import { withAccelerate } from "@prisma/extension-accelerate";
import { Hono } from "hono";
import { UserLoginSchema, UserSchema } from "../schema_validation";
import { sign } from "hono/jwt";
import { hashPassword } from "../util/hashed-password";
import bcrypt from 'bcryptjs';


const userRouter = new Hono<{
    Bindings: {
        DATABASE_URL: string,
        JWT_SECRET: string
    }
}>()

userRouter.get('/', async (c) => {
    return c.json(c.env.JWT_SECRET)
})

userRouter.post('/signup', async (c) => {
    const prisma = new PrismaClient({
        datasourceUrl: c.env?.DATABASE_URL
    }).$extends(withAccelerate())
    const body = await c.req.json();
    const { success } = UserSchema.safeParse(body);
    if (!success) {
        return c.json({ message: 'Invalid Output' })
    } else {
        const checkUsername = await prisma.user.findUnique({ where: { username: body.username } });
        if (checkUsername) {
            c.status(409)
            return c.json({ message: 'Email ALready  Exists.' })
        } else {
            const hashedPassword = await hashPassword(body.password);
            const fromData = await prisma.user.create({
                data: {
                    username: body.username,
                    password: hashedPassword,
                    isAdmin: body.isAdmin
                }
            })
            if (!fromData) {
                throw new Error("Failed to create user")
            }
            else {
                const jwt = await sign({
                    id: fromData.id
                }, c.env?.JWT_SECRET)
                return c.json({ token: jwt, data: fromData })
            }
        }

    }
})

userRouter.post('/signin', async (c) => {
    const prisma = new PrismaClient({
        datasourceUrl: c.env?.DATABASE_URL
    }).$extends(withAccelerate())

    const body = await c.req.json();
    const { success } = UserLoginSchema.safeParse(body)
    if (!success) {
        c.status(401)
        return c.json("Input worngs")
    } else {
        try {
            const checkUser = await prisma.user.findUnique({
                where: {
                    username: body.username
                }
            })
            if (!checkUser) {
                return c.json({ message: "Username not found" })
            }
            const isPasswordValid = await bcrypt.compare(body.password, checkUser.password);

            if (isPasswordValid) {
                const jwt = await sign({
                    id: checkUser.id
                }, c.env?.JWT_SECRET)
                return c.json({
                    message: "Login Successfully",
                    token: jwt
                })
            } else {
                c.status(403)
                return c.json({ message: "Password  wrong" })
            }
        } catch (e) {
            return c.json(e)
        }
    }

})

export default userRouter

