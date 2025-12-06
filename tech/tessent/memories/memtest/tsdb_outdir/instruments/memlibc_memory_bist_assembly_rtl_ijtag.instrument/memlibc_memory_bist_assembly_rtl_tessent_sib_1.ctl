//-------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2022.3
//       Created on: Sat Nov 15 20:33:15 EST 2025
//-------------------------------------------------


STIL 1.0 {
  Design 2005;
  CTL 2005;
}
Header {
  Title "CTL for design 'memlibc_memory_bist_assembly_rtl_tessent_sib_1'";
  Date "Sat Nov 15 20:33:15 EST 2025";
  Source "Tessent Shell 2022.3";
}
Signals {
  ijtag_reset In;
  ijtag_sel In;
  ijtag_si In;
  ijtag_ce In;
  ijtag_se In;
  ijtag_ue In;
  ijtag_tck In;
  ijtag_so Out;
  ijtag_from_so In;
  ltest_si In;
  ltest_scan_en In;
  ltest_en In;
  ltest_clk In;
  ltest_mem_bypass_en In;
  ltest_mcp_bounding_en In;
  ltest_occ_en In;
  ltest_async_set_reset_static_disable In;
  ltest_static_clock_control_mode In;
  ltest_clock_sequence[0] In;
  ltest_clock_sequence[1] In;
  ijtag_to_tck Out;
  ijtag_to_reset Out;
  ijtag_to_si Out;
  ijtag_to_ce Out;
  ijtag_to_se Out;
  ijtag_to_ue Out;
  ltest_so Out;
  ltest_to_en Out;
  ltest_to_mem_bypass_en Out;
  ltest_to_mcp_bounding_en Out;
  ltest_to_scan_en Out;
  ijtag_to_sel Out;
}
SignalGroups {
  all_inputs = 'ijtag_reset + ijtag_sel + ijtag_si + ijtag_ce + ijtag_se + ijtag_ue + ijtag_tck + ijtag_from_so + ltest_si + ltest_scan_en + ltest_en + ltest_clk + ltest_mem_bypass_en + ltest_mcp_bounding_en + ltest_occ_en + ltest_async_set_reset_static_disable + ltest_static_clock_control_mode + ltest_clock_sequence[0] + ltest_clock_sequence[1]';
  all_outputs = 'ijtag_so + ijtag_to_tck + ijtag_to_reset + ijtag_to_si + ijtag_to_ce + ijtag_to_se + ijtag_to_ue + ltest_so + ltest_to_en + ltest_to_mem_bypass_en + ltest_to_mcp_bounding_en + ltest_to_scan_en + ijtag_to_sel';
  all_ports = 'all_inputs + all_outputs';
}
ScanStructures {
  ScanChain "chain_0" {
    ScanLength 7;
    ScanIn ltest_si;
    ScanOut ltest_so;
    ScanEnable ltest_scan_en;
    ScanMasterClock ltest_clk;
  }
}
Timing timing {
}
MacroDefs {
}
Environment memlibc_memory_bist_assembly_rtl_tessent_sib_1 {
  CTLMode internal_test {
    TestMode InternalTest;
    DomainReferences {
    }
    Internal {
      ltest_si {
        ScanStyle MultiplexedData;
        DataType ScanDataIn {
          ScanDataType Internal;
        }
        CaptureClock ltest_clk {
          LeadingEdge ;
        }
      }
      ltest_scan_en {
        DataType ScanEnable {
          ActiveState ForceUp;
        }
      }
      ltest_en {
        DataType TestMode {
          ActiveState ForceUp;
        }
      }
      ltest_clk {
        DataType ScanMasterClock {
          ActiveState ForceUp;
        }
      }
      ltest_so {
        ScanStyle MultiplexedData;
        DataType ScanDataOut {
          ScanDataType Internal;
        }
        LaunchClock ltest_clk {
          TrailingEdge ;
        }
      }
    }
  }
}

