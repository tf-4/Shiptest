import { useBackend } from '../backend';
import { Window } from '../layouts';

export const ResearchGridUI = (props, context) => {
  const { act, data } = useBackend(context);
  const { node_name } = data;
  return (
    <Window title={'Research Grid: ' + node_name}>
      {Object.keys(data).map((key) => (
        <p key={key}>{key}</p>
      ))}
    </Window>
  );
};
