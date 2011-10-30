TITLE = compsc

EPS = selfemu.eps pack_state.eps arch.eps switch.eps
EPS += perf_tp.eps perf_spec_req.eps perf_spec_250.eps perf_spec_resp.eps
EPS += perf_10g_tp.eps perf_10g_spec_req.eps perf_10g_spec_resp.eps
EPS += timeline_compsc.eps timeline_pv.eps timeline_bond.eps
EPS += timeline_10g_compsc.eps timeline_10g_pv.eps timeline_10g_vmdq.eps

include ../scripts/tex.mk

timeline_compsc.eps: timeline_compsc.plot migdata/compsc_tp.txt migdata/compsc_cpu.txt
	gnuplot <(echo set output \"$@\") $(basename $@).plot

timeline_pv.eps: timeline_pv.plot migdata/pv_tp.txt migdata/pv_cpu.txt
	gnuplot <(echo set output \"$@\") $(basename $@).plot

timeline_bond.eps: timeline_bond.plot migdata/bond_tp.txt migdata/bond_cpu.txt
	gnuplot <(echo set output \"$@\") $(basename $@).plot

timeline_10g_compsc.eps: timeline_10g_compsc.plot migdata/10g_compsc_tp.txt migdata/10g_compsc_cpu.txt
	gnuplot <(echo set output \"$@\") $(basename $@).plot

timeline_10g_pv.eps: timeline_10g_pv.plot migdata/10g_pv_tp.txt migdata/10g_pv_cpu.txt
	gnuplot <(echo set output \"$@\") $(basename $@).plot

timeline_10g_vmdq.eps: timeline_10g_vmdq.plot migdata/10g_vmdq_tp.txt migdata/10g_vmdq_cpu.txt
	gnuplot <(echo set output \"$@\") $(basename $@).plot
