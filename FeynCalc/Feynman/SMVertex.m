(* ::Package:: *)

(* ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(* :Title: SMVertex											*)

(*
	This software is covered by the GNU Lesser General Public License 3.
	Copyright (C) 1990-2015 Rolf Mertig
	Copyright (C) 1997-2015 Frederik Orellana
	Copyright (C) 2014-2015 Vladyslav Shtabovenko
*)

(* :Summary: Some Standard model vertices									*)

(* ------------------------------------------------------------------------ *)

SMVertex::usage =
"SMVertex[\"AWW\", p,mu, q,nu, k,rho] gives the photon-W-W vertex \
(p,mu correspond to the photon, q,nu to the (incoming) W+ and k,rho \
to the (incoming) W-. All momenta are flowing into the vertex. \n
SMVertex[\"HHH\", ___] give the three-higgs coupling.";

(* ------------------------------------------------------------------------ *)

Begin["`Package`"]
End[]

Begin["`SMVertex`Private`"]

Options[SMVertex] = {
	Dimension -> 4,
	Explicit -> True
};

l[w_Integer]:=
	FCGV["li"<>ToString[w]];

(*TODO Add all the SM vertices from Boehm and Denner *)

SMVertex[x___, i_Integer, y___] :=
	SMVertex[x, l[i], y];


SMVertex["AWW", mom1_, li1_, mom2_, li2_, mom3_, li3_, OptionsPattern[]] :=
	Block[	{dim, res},
		res = ChangeDimension[
			-I*SMP["EL"]*( MetricTensor[li1, li2] * FourVector[(mom2 -mom1 ),li3]+
					MetricTensor[li2, li3] * FourVector[(mom3 -mom2 ),li1]+
					MetricTensor[li3, li1] * FourVector[(mom1 -mom3 ),li2]), OptionValue[Dimension]];
		res
	]/; OptionValue[Explicit];


SMVertex["HHH", OptionsPattern[]] :=
	Block[ {EL, MW, MH, SW},
		{EL, MW, MH, SW} = SMP /@ {"EL", "MW", "MH", "SW"};
		(* directly from the SM.model file from FeynArts1.0 *)
		((-3*I)/2*EL*MH^2)/(MW*SW)
	];

SMVertex["eeH", OptionsPattern[]] :=
	Block[ {EL, MW, MH, SW},
		{EL, MW, ME, SW} = SMP /@ {"EL", "MW", "ME", "SW"};
		-((I*EL*ME)/(2*MW*SW))
	];

FCPrint[1,"SMVertex.m loaded."];
End[]
