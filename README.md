# 🚀 Accelerated Molecular Dynamics (aMD) Setup

This folder contains scripts and instructions for running **Accelerated Molecular Dynamics (aMD)**  
simulations in **AMBER** to enhance sampling and explore a wider conformational landscape.

---

## 📖 Overview

**aMD** is a powerful enhanced-sampling method that modifies the potential energy surface to  
lower energy barriers and raise minima, allowing faster exploration of conformational space.

In this workflow:
- We collect **average total potential** and **average dihedral energy** from a conventional MD run.
- Calculate **EthreshP**, **alphaP**, **EthreshD**, and **alphaD** using a simple Python script.
- Generate a customized aMD input file (`prod1.in.start`) with:
  - Reduced timestep (`dt=0.002`) to avoid instabilities
  - Proper output frequencies (`ntwx`, `ntpr`, `ntwr`)
  - aMD boost parameters (`iamd=3`, thresholds, and alphas)
- Run in **100 ns chunks**, continuing with `prod1.in` until reaching the desired timescale (e.g., 1 μs).

---

## 🧩 Prerequisites

- Working **AMBER installation** (`pmemd.cuda`, `cpptraj`, `process_mdout.perl` available in `$PATH`)
- Completed one of the standard production runs:
  - `Amber_Covalent_Run`
  - `Amber_Apo_Protein_Run`
  - `Amber_Noncovalent_Run`
- At least **100 ns** of production data available (more is better, e.g., 500 ns – 1 μs)

---

## 🛠️ Workflow

1. **Compute Average Energies**
   - Use `process_mdout.perl` to extract total potential energy
   - Use `cpptraj` to extract dihedral energy (`dihed.dat`)

2. **Calculate aMD Parameters**
   - Run the `aMD Parameter Report Generator` (Python script)  
   - Get `EthreshP`, `alphaP`, `EthreshD`, and `alphaD`

3. **Generate Input Files**
   - `prod1.in.start` → used for the first 100 ns production run  
   - `prod1.in` → used by plumed driver to continue multiple 100 ns chunks until 1 μs total

4. **Run aMD Simulation**
   - Launch with `pmemd.cuda` or `pmemd.MPI`
   - Automate chunked runs using `production.pl` or a job scheduler

---

## 🔗 Reference

Full theoretical background and parameter selection guidelines:  
➡️ [AMBER aMD Tutorial – Section 2](https://ambermd.org/tutorials/advanced/tutorial22/section2.php)

---

## 📂 Output

- `summary_avg.EPTOT` – Average total potential energy  
- `dihed.dat` – Per-frame dihedral energies  
- `prod1.in.start` / `prod1.in` – aMD production input files  

Use these to launch long-timescale aMD runs and collect enhanced sampling data for analysis.
