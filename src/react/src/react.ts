import { handlerFunc } from 'crayon'
import { mount } from 'crayon';
import { ReactState } from './state';

export const router = (
  target: HTMLElement = document.body, 
  className: string = 'router-view'
): handlerFunc => (req, res, state) => {
  if (state.reactState === undefined) {
    state.reactState = new ReactState(target, className)
  }
  res.mount = (Component: any): Promise<any> => {
    const animationName = res && res.ctx && res.ctx.animation && res.ctx.animation.name
    const animationDuration = res && res.ctx && res.ctx.animation && res.ctx.animation.duration
    return mount(
      Component,
      state.reactState.mounter,
      animationName,
      animationDuration
    )
  }
}