import { Op } from "sequelize";
import Convocatoria from "../models/convocatoria";

export async function cerrarConvocatoriasVencidas() {
  const hoy = new Date();

  const vencidas = await Convocatoria.findAll({
    where: {
      estado_id: { [Op.ne]: 4 }, // evita duplicar cierre
      fecha_cierre: { [Op.lte]: hoy },
    },
  });

  for (const convocatoria of vencidas) {
    (convocatoria as any).estado_id = 4; // Finalizada
    await convocatoria.save();
    console.log(
      `📌 Convocatoria ${(convocatoria as any).id} cerrada automáticamente`
    );
  }
}
