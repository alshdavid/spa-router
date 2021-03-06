import "./styles.scss"
import crayon from "crayon"
import crayonReact from "crayon-react"
import transition from "crayon-transition"
import animate from "crayon-animate"
import * as pages from "./pages"
import { AppContext, ctx } from "./context"

const outlet = document.getElementById("router-outlet")
const router = crayon.create()
ctx.router = router

router.use(crayonReact.router(outlet))
router.use(crayonReact.withContext(AppContext, ctx))
router.use(transition.loader())
router.use(
  animate.defaults({
    name: transition.fade,
    duration: 1000
  })
)
router.use(
  animate.routes([
    { from: "/**", to: "/more", name: transition.slideLeft },
    { from: "/more", to: "/**", name: transition.slideRight }
  ])
)

router.path("/", 
  (req, res) => res.redirect("/home")
)

router.path("/home", 
  (req, res) => res.mount(pages.Route)
)

router.path("/about", 
  (req, res) => res.mount(pages.Route)
)

router.path("/more", 
  (req, res) => res.mount(pages.More)
)

router.load()
