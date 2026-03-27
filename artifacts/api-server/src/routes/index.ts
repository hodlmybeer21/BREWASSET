import { Router, type IRouter } from "express";
import healthRouter from "./health.js";
import authRouter from "./auth.js";
import inventoryRouter from "./inventory.js";
import requestsRouter from "./requests.js";
import eventsRouter from "./events.js";
import transfersRouter from "./transfers.js";
import staffRouter from "./staff.js";
import catalogRouter from "./catalog.js";
import accountsRouter from "./accounts.js";
import usersRouter from "./users.js";
import customersRouter from "./customers.js";

const router: IRouter = Router();

router.use(healthRouter);
router.use("/auth", authRouter);
router.use("/inventory", inventoryRouter);
router.use("/requests", requestsRouter);
router.use("/events", eventsRouter);
router.use("/transfers", transfersRouter);
router.use("/staff", staffRouter);
router.use("/catalog", catalogRouter);
router.use("/accounts", accountsRouter);
router.use("/users", usersRouter);
router.use("/customers", customersRouter);

export default router;
