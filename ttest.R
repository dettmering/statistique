welch <- function(ctrl.x, ctrl.sd, ctrl.n, smpl.x, smpl.sd, smpl.n) {
  ctrl.sd.sq <- (ctrl.sd^2 / ctrl.n)
  smpl.sd.sq <- (smpl.sd^2 / smpl.n)
  variance <- ctrl.sd.sq + smpl.sd.sq
  
  t <- (ctrl.x - smpl.x) / sqrt(variance)
  df <- variance^2 / ((ctrl.sd.sq^2 / (ctrl.n - 1)) + (smpl.sd.sq^2 / (smpl.n - 1)))
  p <- 2 * pt(-abs(t), df)
  
  pi <- abs(log2(smpl.x / ctrl.x)) * -log10(p) # pi significance score, after Xiao et al. (2012), doi:10.1093/bioinformatics/btr671
  
  result <- cbind(t, df, p, pi)
  return(result)
}

significance.stars <- function(pvalue) {
  if (is.na(pvalue)) {star <- ''}
  else {
    if (pvalue > 0.05) {star <- ''}
    if (pvalue <= 0.05) {star <-'*'}
    if (pvalue <= 0.01) {star <- '**'}
    if (pvalue <= 0.001) {star <- '***'}
    if (pvalue <= 0.0001) {star <- '****'}
  }

  return(star)
}