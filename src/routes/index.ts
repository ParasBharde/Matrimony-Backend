import { Hono } from "hono";
import userRouter from "./user";
import profileRouter from "./profile";

const mainRouter = new Hono()

mainRouter.route('/user-cred',userRouter)
mainRouter.route('/profile',profileRouter)

export default mainRouter

