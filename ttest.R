welch <- function(ctrl.x, ctrl.sd, ctrl.n, smpl.x, smpl.sd, smpl.n) {
  ctrl.sd.sq <- (ctrl.sd^2 / ctrl.n)
  smpl.sd.sq <- (smpl.sd^2 / smpl.n)
  variance <- ctrl.sd.sq + smpl.sd.sq
  
  t <- (ctrl.x - smpl.x) / sqrt(variance)
  df <- variance^2 / ((ctrl.sd.sq^2 / (ctrl.n - 1)) + (smpl.sd.sq^2 / (smpl.n - 1)))
  p <- 2 * pt(-abs(t), df)
  
  result <- cbind(t,df,p)
  return(result)
}