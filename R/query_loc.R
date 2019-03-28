#' query calls at a position in a Terra-based genetics cohort
#' @param con BigQueryConnection instance
#' @param tablename character(1) table with variants
#' @param chr character(1) chromosome id, NCBI-like
#' @param pos numeric(1) position on chromosome, exact
#' @note Metadata should be supplied.
#' @export
query_loc = function(con, tablename="1000_genomes_phase_3_variants_20150220", chr, pos) {
  chr = as.character(chr)  # safety
  tmp = (con %>% tbl(tablename) %>% select(reference_name, start_position, names, call) %>%
    filter(reference_name==chr, start_position==pos) %>% as.data.frame())
  data.frame(id=as.character(tmp$call[[1]]$name), snp=as.character(tmp$names), call=sapply(tmp$call[[1]]$genotype,sum))
}
