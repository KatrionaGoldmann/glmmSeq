% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/glmmSeq.R
\name{glmmSeq}
\alias{glmmSeq}
\title{Glmm for sequencing results}
\usage{
glmmSeq(
  modelFormula,
  countdata,
  metadata,
  id,
  dispersion,
  sizeFactors = NULL,
  reducedFormula = "",
  modelData = NULL,
  control = glmerControl(optimizer = "bobyqa"),
  cores = 1,
  removeDuplicatedMeasures = FALSE,
  removeSingles = FALSE,
  zeroCount = 0.125,
  verbose = TRUE,
  returnList = FALSE,
  progress = TRUE,
  ...
)
}
\arguments{
\item{modelFormula}{the model formula. For more information of formula
structure see \code{\link[lme4:glmer]{lme4::glmer()}}}

\item{countdata}{the sequencing count data}

\item{metadata}{a data frame of sample information}

\item{id}{Column name in metadata which contains the sample IDs to be used
in pairing samples}

\item{dispersion}{a numeric vector of gene dispersion}

\item{sizeFactors}{size factors (default = NULL). If provided the glmer
offset is set to log(sizeFactors). For more information see
\code{\link[lme4:glmer]{lme4::glmer()}}}

\item{reducedFormula}{Reduced design formula (default = "")}

\item{modelData}{Expanded design matrix}

\item{control}{the glmer control (default = glmerControl(optimizer =
"bobyqa")). For more information see
\code{\link[lme4:glmerControl]{lme4::glmerControl()}}.}

\item{cores}{number of cores to use. Default = 1.}

\item{removeDuplicatedMeasures}{whether to remove duplicated
conditions/repeated measurements for a given time point (default = FALSE).}

\item{removeSingles}{whether to remove individuals with only one measurement
(default = FALSE)}

\item{zeroCount}{numerical value to offset zeroes for the purpose of log
(default = 0.125)}

\item{verbose}{Logical whether to display messaging (default = TRUE)}

\item{returnList}{Logical whether to return results as a list or glmmSeq
object (default = FALSE).}

\item{progress}{Logical whether to display a progress bar}

\item{...}{Other parameters to pass to
\code{\link[lme4:glmer]{lme4::glmer()}}}
}
\value{
Returns a GlmmSeq object with results for gene-wise general linear
mixed models or a list of results if returnList is TRUE.
}
\description{
Glmm for sequencing results
}
\examples{
data(PEAC_minimal_load)
disp <- apply(tpm, 1, function(x) {
(var(x, na.rm = TRUE)-mean(x, na.rm = TRUE))/(mean(x, na.rm = TRUE)**2)
})
MS4A1glmm <- glmmSeq(~ Timepoint * EULAR_6m + (1 | PATID),
                     id = "PATID",
                     countdata = tpm["MS4A1", ],
                     metadata = metadata,
                     dispersion = disp["MS4A1"],
                     verbose = FALSE)
names(attributes(MS4A1glmm))
}
